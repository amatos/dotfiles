# Generated from dawnix modules/shell/shell-functions-posix.nix. Edit here, not there.
# Sourced by ~/.bashrc and ~/.config/zsh/.zshrc.

reload-gpg-agent() {
echo "🔁 Reloading GPG agent..."
gpg-connect-agent reloadagent /bye && echo "✅ GPG agent reloaded."
}

reload-yubikey() {
echo "🔄 Relearning YubiKey smartcard..."
gpg-connect-agent "scd serialno" "learn --force" /bye && echo "✅ YubiKey smartcard reloaded."
}

reload-pcsd() {
echo "🔁 Restarting smartcard daemon (pcscd)..."
if [ "$(uname)" = Darwin ]; then
  sudo launchctl kickstart -k system/com.apple.pcscd
else
  sudo systemctl restart pcscd.service
fi && echo "✅ pcscd restarted."
}

yubikey-reset() {
echo "🔐 Starting full YubiKey + GPG reset..."

echo
echo "🔁 Restarting smartcard services..."
if [ "$(uname)" = Darwin ]; then
  sudo launchctl kickstart -k system/com.apple.pcscd
else
  sudo systemctl restart pcscd.service
  sudo systemctl restart pcscd.socket
fi

echo
echo "🔁 Reloading GPG agent..."
reload-gpg-agent

echo
echo "🔄 Refreshing YubiKey smartcard..."
reload-yubikey

echo
echo "📇 Checking GPG smartcard status..."
gpg --card-status || echo "⚠️  Unable to read card status."

echo
echo "🧮 Getting PIN retry counters..."
gpg-connect-agent 'scd getinfo retry_counter' /bye 2>/dev/null || echo "⚠️  Could not fetch retry counters."

echo
echo "🔍 Checking SSH agent socket and identities..."
if [ -n "$SSH_AUTH_SOCK" ]; then
  echo "📡 SSH agent socket detected at: $SSH_AUTH_SOCK"
  ssh-add -L || echo "⚠️  No SSH keys loaded via agent."
else
  echo "❌ SSH agent socket not found."
fi

echo
echo "✅ YubiKey and related services reset complete."
}

ssh-load-yubikey() {
gpg-connect-agent updatestartuptty /bye && ssh-add -L
}

docker-stop-containers() {
echo "🛑 Stopping all running containers..."
docker ps -q | xargs -r docker stop && echo "✅ All containers stopped."
}

docker-pause-containers() {
echo "⏸️ Pausing all running containers..."
docker ps -q | xargs -r docker pause && echo "✅ All containers paused."
}

docker-remove-containers() {
echo "🧼 Removing all stopped containers..."
docker ps -a -q | xargs -r docker rm && echo "✅ Stopped containers removed."
}

docker-delete-images() {
echo "🧹 Deleting all Docker images..."
docker images -q | xargs -r docker rmi && echo "✅ All images removed."
}

docker-delete-volumes() {
echo "🗑️ Removing dangling volumes..."
docker volume ls -qf dangling=true | xargs -r docker volume rm && echo "✅ Dangling volumes removed."
}

docker-delete-all() {
echo "🔥 Stopping all containers and pruning system..."
docker ps -q | xargs -r docker stop
docker system prune -a --volumes -f && echo "✅ Docker system fully cleaned."
}

docker-delete-app() {
if [ "$#" -eq 0 ]; then
  echo "⚠️  Usage: docker-delete-app <name>"
  return 1
fi
echo "🗑️ Searching for containers matching \"$1\"..."
for id in $(docker ps -a | grep -- "$1" | awk '{print $1}'); do
  echo "➤ Removing container: $id"
  docker rm "$id"
done
echo "✅ Matching containers removed."
}

tail-vpn-restart() {
echo "🔄 Restarting Tailscale..."
if tailscale status >/dev/null 2>&1; then
  echo "⬇️ Stopping Tailscale..."
  sudo tailscale down
else
  echo "ℹ️ Tailscale already down."
fi
echo "⬆️ Starting Tailscale..."
sudo tailscale up
echo
echo "📡 Current Tailscale status:"
sudo tailscale status
if [ "$#" -gt 0 ]; then
  echo
  echo "🔎 DNS check for: $1"
  nslookup "$1" || echo "❌ DNS lookup failed for $1"
fi
echo "✅ Tailscale restart complete."
}

current-exit-node() {
echo "📍 Current exit node info:"
tailscale status | grep "$(tailscale ip -4)"
tailscale status --json | jq '.ExitNodeIP'
}

use-exit-node() {
            echo "🌐 Scanning for available exit nodes..."
            local reset_line="RESET   🔄   [Disable Exit Node]"
            local choices
            choices=$(tailscale status \
              | grep -i 'offers exit node' \
              | grep -vi 'offline' \
              | awk '{ip=$1; host=$2; status=""; for(i=5;i<=NF;++i){status=status" "$i}; print ip "|" host "|" status}' \
              | column -t -s '|')
            choices="$choices
$reset_line"
            local selected
            selected=$(printf '%s\n' "$choices" | fzf \
              --prompt="🔘 Select an exit node (or reset): " \
              --header="IP Address        Hostname               Status" \
              --height=30% --reverse --ansi)
            if [ -z "$selected" ]; then
              echo "❌ Cancelled or no selection made."
              return 1
            fi
            if [ "$selected" = "$reset_line" ]; then
              echo "🚫 Disabling exit node..."
              tailscale set --exit-node=
              echo "✅ Exit node disabled."
              return 0
            fi
            local ip
            ip=$(echo "$selected" | awk '{print $1}')
            echo "🚀 Switching to exit node: $ip"
            tailscale set --exit-node="$ip" && echo "✅ Now using exit node: $ip"
}

use-tailscale() {
local jq_exit='if (.ExitNodeStatus.ID // "") == "" then "none" else (.ExitNodeStatus.ID) as $id | (([ .Peer // {} | to_entries[] | select(.value.ID == $id) | .value.HostName ][0]) // (.ExitNodeStatus.TailscaleIPs[0] | sub("/.*"; ""))) end'
local exit_node
exit_node=$(tailscale status --json 2>/dev/null | jq -r "$jq_exit")
[ -z "$exit_node" ] && exit_node="none"
local routes="off"
if [ "$(tailscale debug prefs 2>/dev/null | jq -r '.RouteAll')" = "true" ]; then
  routes="on"
fi
local action
action=$(printf "%s\n" \
  "🌐 Exit node        (active: $exit_node)" \
  "🛣  Accept routes     (currently: $routes)" \
  | fzf --prompt="🔧 use-tailscale ▸ " \
    --header="Select a Tailscale setting to manage" \
    --height=20% --reverse --ansi)
case "$action" in
  *"Exit node"*)
    use-exit-node
    ;;
  *"Accept routes"*)
    if [ "$routes" = "on" ]; then
      echo "🚫 Disabling accept-routes (subnet routes)..."
      tailscale set --accept-routes=false && echo "✅ accept-routes is now OFF"
    else
      echo "✅ Enabling accept-routes (subnet routes)..."
      tailscale set --accept-routes=true && echo "✅ accept-routes is now ON"
    fi
    ;;
  *)
    echo "❌ Cancelled or no selection made."
    return 1
    ;;
esac
}

tail-fix-dns() {
echo "🔧 Restarting DNS services (Tailscale-related)..."
if [ "$(uname)" = Darwin ]; then
  sudo dscacheutil -flushcache
  sudo killall -HUP mDNSResponder
  echo "✅ macOS DNS cache flushed."
else
  if systemctl is-active systemd-resolved >/dev/null 2>&1; then
    sudo systemctl restart systemd-resolved && echo "✅ systemd-resolved restarted."
  else
    echo "⚠️ systemd-resolved not active."
  fi
  if systemctl is-active NetworkManager >/dev/null 2>&1; then
    sudo systemctl restart NetworkManager && echo "✅ NetworkManager restarted."
  else
    echo "⚠️ NetworkManager not active."
  fi
  if systemctl is-active tailscaled >/dev/null 2>&1; then
    sudo systemctl restart tailscaled && echo "✅ tailscaled restarted."
  else
    echo "⚠️ tailscaled not active."
  fi
fi
echo "✅ DNS services refreshed."
}

dns-reset-all() {
echo "🔁 Restarting all DNS-related services..."
if [ "$(uname)" = Darwin ]; then
  sudo dscacheutil -flushcache
  sudo killall -HUP mDNSResponder
  echo "✅ macOS DNS cache flushed."
else
  sudo systemctl restart systemd-resolved && echo "✅ systemd-resolved restarted."
  sudo systemctl restart NetworkManager && echo "✅ NetworkManager restarted."
  sudo systemctl restart tailscaled && echo "✅ tailscaled restarted."
  sudo systemctl restart resolvconf && echo "✅ resolvconf restarted."
fi
echo "✅ All DNS components reset."
}

_mynet_ip() {
local GRN CYN NC
GRN=$'\033[0;32m'
CYN=$'\033[0;36m'
NC=$'\033[0m'
echo "$GRN""Local Network IPs""$NC"
if [ "$(uname)" = Darwin ]; then
  echo "$GRN""Interfaces:""$NC"
  ifconfig | awk -v c="\033[0;36m" -v n="\033[0m" \
    '/^[a-z]/{gsub(/:$/,"",$1); state=($2 ~ /UP/)?"UP":"DOWN"; printf "   - %s%-18s%s  %s\n", c, $1, n, state}'
  echo "$GRN""IPv4 Addresses:""$NC"
  ifconfig | awk -v c="\033[0;36m" -v n="\033[0m" \
    '/^[a-z]/{gsub(/:$/,"",$1); iface=$1} /inet /{printf "   - %s%-18s%s  %s\n", c, iface, n, $2}'
  echo "$GRN""IPv6 Addresses:""$NC"
  ifconfig | awk -v c="\033[0;36m" -v n="\033[0m" \
    '/^[a-z]/{gsub(/:$/,"",$1); iface=$1} /inet6/{printf "   - %s%-18s%s  %s\n", c, iface, n, $2}'
else
  echo "$GRN""Interfaces:""$NC"
  ip -br link show | awk -v c="\033[0;36m" -v n="\033[0m" \
    '{sub(/@.*/,"",$1); printf "   - %s%-18s%s  %s\n", c, $1, n, $2}'
  echo "$GRN""IPv4 Addresses:""$NC"
  ip -4 -o addr show | awk -v c="\033[0;36m" -v n="\033[0m" \
    '{split($4,a,"/"); printf "   - %s%-18s%s  %s\n", c, $2, n, a[1]}'
  echo "$GRN""IPv6 Addresses:""$NC"
  ip -6 -o addr show | awk -v c="\033[0;36m" -v n="\033[0m" \
    '{split($4,a,"/"); printf "   - %s%-18s%s  %s\n", c, $2, n, a[1]}'
fi
echo "$GRN""Public IPs (via multiple sources):""$NC"
dig +short whoami.akamai.net @ns1-1.akamaitech.net | awk -v c="\033[0;36m" -v n="\033[0m" '{printf "   %sAkamai%s      : %s\n", c, n, $1}'
curl -s ifconfig.me/ip | cut -f1 -d"%" | awk -v c="\033[0;36m" -v n="\033[0m" '{printf "   %sifconfig.me%s : %s\n", c, n, $1}'
echo "$GRN""Tailscale Info:""$NC"
if command -v tailscale >/dev/null 2>&1; then
  tailscale ip -4 2>/dev/null | awk -v c="\033[0;36m" -v n="\033[0m" '{printf "   %sIP:%s      %s\n", c, n, $1}'
  local _tsdomain
  _tsdomain=$(tailscale status 2>/dev/null | head -1 | awk '{sub(/^[^.]+\./, "", $3); print $3}')
  [ -n "$_tsdomain" ] && printf "   %sTailnet:%s %s\n" "$CYN" "$NC" "$_tsdomain"
  local _tsemail
  _tsemail=$(tailscale status --json 2>/dev/null | jq -r '.CurrentTailnet.Name // empty')
  [ -n "$_tsemail" ] && printf "   %sEmail:%s   %s\n" "$CYN" "$NC" "$_tsemail"
else
  local YLW
  YLW=$'\033[0;33m'
  printf "   %s(not installed)%s\n" "$YLW" "$NC"
fi
}

_mynet_info() {
local CYN GRN YLW NC
CYN=$'\033[0;36m'
GRN=$'\033[0;32m'
YLW=$'\033[0;33m'
NC=$'\033[0m'
echo "$GRN""Fetching extended network info via ipwho.is...""$NC"
local data
data=$(curl -s http://ipwho.is/)
if [ -z "$data" ]; then
  printf "  %sCould not reach ipwho.is%s\n" "$YLW" "$NC"
  return 1
fi
for field in ip type country region city timezone.id timezone.utc timezone.current_time connection.isp; do
  local label="$field"
  case "$field" in
    ip) label="IP" ;;
    type) label="IP Type" ;;
    country) label="Country" ;;
    region) label="Region" ;;
    city) label="City" ;;
    timezone.id) label="Timezone" ;;
    timezone.utc) label="UTC Offset" ;;
    timezone.current_time) label="Local Time" ;;
    connection.isp) label="ISP" ;;
  esac
  local val
  val=$(printf '%s' "$data" | jq -r ".$field // \"n/a\"")
  printf "  %s%-14s%s %s\n" "$CYN" "$label" "$NC" "$val"
done
}

_mynet_table() {
local CYN GRN YLW DIM NC
CYN=$'\033[0;36m'
GRN=$'\033[0;32m'
YLW=$'\033[0;33m'
DIM=$'\033[2m'
NC=$'\033[0m'
echo "$GRN""Getting your current public IP...""$NC"
local ip
ip=$(curl -s https://ifconfig.me)
if [ -z "$ip" ]; then
  printf "%sCould not retrieve IP.%s\n" "$YLW" "$NC"
  return 1
fi
printf "%sLooking up details using ipwho.is...%s\n" "$DIM" "$NC"
local ipwho_data
ipwho_data=$(curl -s "https://ipwho.is/")
local country
country=$(printf '%s' "$ipwho_data" | jq -r '.country')
local isp
isp=$(printf '%s' "$ipwho_data" | jq -r '.connection.isp' | awk '{print $1}')
[ -z "$country" ] || [ "$country" = "null" ] && country="Unknown"
[ -z "$isp" ] || [ "$isp" = "null" ] && isp="Unknown"
echo
echo "$GRN""Current IP Info:""$NC"
printf "   %s%-18s %-20s %s%s\n" "$CYN" "IP Address" "Country" "Provider" "$NC"
printf "   %-18s %-20s %s\n" "$ip" "$country" "$isp"
echo
echo "$GRN""Full IP List:""$NC"
printf "%s%-26s %-16s %s%s\n" "$CYN" "IP Address" "Country" "Provider" "$NC"
printf "%s\t%s\t%s\n" "$ip" "$country" "$isp" | column -t -s $'\t'
}

mynet() {
local subcmd="ip"
if [ "$#" -gt 0 ]; then
  subcmd="$1"
else
  subcmd="all"
fi
case "$subcmd" in
  ip) _mynet_ip ;;
  info) _mynet_info ;;
  table) _mynet_table ;;
  all)
    _mynet_ip
    echo
    _mynet_info
    echo
    _mynet_table
    ;;
  *)
    echo "Usage: mynet [ip|info|table]"
    echo "  ip    — local, public, and Tailscale IPs"
    echo "  info  — geo/ISP lookup via ipwho.is"
    echo "  table — formatted table with static entries"
    echo "  (no arg) — run all three"
    return 1
    ;;
esac
}

myping() {
if [ "$#" -eq 0 ]; then
  echo "Usage: myping <host> [ping args...]"
  return 1
fi
ping "$@" | while IFS= read -r line; do
  printf "[%s] %s\n" "$(date '+%H:%M:%S')" "$line"
done
}

zox() {
echo "📂 Choose a recent directory to jump into:"
local dir
dir=$(zoxide query -l | fzf --preview="ls -lh --color=always {} 2>/dev/null" --preview-window=up:30%)
if [ -n "$dir" ]; then
  echo "🚀 Jumping to: $dir"
  cd "$dir" || echo "❌ Failed to cd into $dir"
else
  echo "❌ No directory selected."
fi
}
