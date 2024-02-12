function aur
    set -xg AUR_USERNAME $(op item get "Archlinux AUR" --fields label=user)
    set -xg AUR_PASSWORD $(op item get "Archlinux AUR" --fields label=user)
end
