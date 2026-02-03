############################################################
#
#     ███████╗██╗███████╗██╗  ██╗
#     ██╔════╝██║██╔════╝██║  ██║
#     █████╗  ██║███████╗███████║
#     ██╔══╝  ██║╚════██║██╔══██║
#     ██║     ██║███████║██║  ██║
#     ╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝
#
############################################################

switch (uname)
case "Darwin"
    set -gx PATH /opt/homebrew/bin \
        ~/.local/bin \
        $PATH
case 'Linux'
    set -gx PATH ~/.local/bin \
        $PATH
end

# Install fisher if not already installed
install_fisher

set -q fisher_path; or set -Ux fisher_path "$HOME/.config/fish"

# `rm` -> `trash` (macOS), if available
if type -q trash
  function rm; trash $argv; end
  complete --command rm --wraps 'rm'
end

# # fifc
# set -gx fifc_exa_opts --all --color=always --icons

# fifc \
#     -r '^(pacman|paru)(\\h*\\-S)?\\h+' \
#     -s 'pacman --color=always -Ss "$fifc_token" | string match -r \'^[^\\h+].*\'' \
#     -e '.*/(.*?)\\h.*' \
#     -f "--query ''" \
#     -p 'pacman -Si "$fifc_extracted"'

# fifc \
#     -r '.*\*{2}.*' \
#     -s 'rg --hidden -l --no-messages (string match -r -g \'.*\*{2}(.*)\' "$fifc_commandline")' \
#     -p 'batgrep --color --paging=never (string match -r -g \'.*\*{2}(.*)\' "$fifc_commandline") "$fifc_candidate"' \
#     -f "--query ''" \
#     -o 'batgrep --color (string match -r -g \'.*\*{2}(.*)\' "$fifc_commandline") "$fifc_candidate" | less -R' \
#     -O 1

# ###################################
# # fzf
# ###################################
set -Ux FZF_DEFAULT_COMMAND "fd -H -E '.git'"
set -gx FZF_DEFAULT_OPTS "
    --layout=reverse
    --height=90%
    --prompt='~ ' --pointer='▶' --marker='✓'
    --multi
    --color='hl:148,hl+:154,pointer:032,marker:010,bg+:237,gutter:008'
    --bind='ctrl-y:execute-silent(echo {+} | xclip)'
    --bind='ctrl-a:select-all'
    --bind='?:toggle-preview'
    --bind='ctrl-o:execute(nvim {+} &> /dev/tty)'
    --bind='ctrl-v:execute(code {+})'
"

fzf_configure_bindings --directory=\cf --processes=\cp --git_log=\cg --git_status=\eg --variables=\cv --history=

# Use eza to list files (with colors) if present
set -gx fzf_preview_dir_cmd eza --all --color=always --icons

set -gx fzf_fd_opts --follow
# Bind ctrl+h to reload with hidden files
set -a fzf_directory_opts --bind='ctrl-h:reload(fd --type file --color=always --hidden --follow --exclude .git)'
# Bind ctrl+x to reload with executable files
set -a fzf_directory_opts --bind='ctrl-x:reload(fd --type executable --color=always --hidden --follow --exclude .git)'
# Bind ctrl+d to reload with directories only
set -a fzf_directory_opts --bind='ctrl-d:reload(fd --type directory --color=always --hidden --follow --exclude .git)'
# Bind ctrl+f to reload with the default search options
set -a fzf_directory_opts --bind='ctrl-f:reload(fd --type file --color=always --follow)'
# Bind ctrl+o to open the current item
set -a fzf_directory_opts --bind="ctrl-o:execute(nvim {} &> /dev/tty)"

# Use delta to show git diff when searching through git log
set -gx fzf_git_log_opts --preview='git show {1} | delta'

# Forgit plugin
set -U forgit_log glo:
set -U forgit_diff gd:
set -U forgit_add ga:
set -U forgit_reset_head grh:
set -U forgit_ignore gif
set -U forgit_restore gcf:
set -U forgit_clean gclean:
set -U forgit_stash_show gss:
set -U forgit_cherry_pick gcp:
set -U forgit_rebase grb:

set ENHANCD_FILTER_OPTS --preview='$fzf_preview_dir_cmd {}' --bind='ctrl-o:execute(broot {})'

# ###################################
# # General settings
# ###################################

set -g direnv_fish_mode eval_on_arrow # trigger direnv at prompt, and on every arrow-based directory change (default)

fish_config theme choose "Dracula Official"

# ###################################
# # homebrew
# ###################################
if [ -e /opt/homebrew/bin/brew ]
    /opt/homebrew/bin/brew shellenv | source
end

# ###################################
# # iTerm shell integration
# ###################################
test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

# ###################################
# # Things to run in interactive sessions
# ###################################
if status is-interactive
    # Commands to run in interactive sessions can go here
    atuin init --disable-up-arrow fish | source # Initialize atuin
    fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc # Display fastfetch
    starship init fish | source # Initialize starship
    jenv init - | source # Initialize jenv
    rbenv init - --no-rehash fish | source
    zoxide init fish | source # Initialize zoxide
    fzf --fish | source # Initialize fzf
    direnv hook fish | source # Initialize direnv
    set -gx BAT_STYLE auto
    set -g theme_color_scheme dracula # Set the color scheme to Dracula
else
    set -gx BAT_STYLE plain
end
