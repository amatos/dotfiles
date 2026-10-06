export OP_PLUGIN_ALIASES_SOURCED=1
alias gh="op plugin run -- gh"
unalias gh 2>/dev/null
unset -f gh 2>/dev/null
gh() {
    op plugin run -- gh "$@"
}
