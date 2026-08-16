[[ $- != *i* ]] && return

[[ -f /usr/share/omarchy-zsh/shell/zoptions ]] &&
    source /usr/share/omarchy-zsh/shell/zoptions
[[ -f /usr/share/omarchy-zsh/shell/all ]] &&
    source /usr/share/omarchy-zsh/shell/all
for _p in /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh \
    /usr/share/zsh/plugins/zsh-transient-prompt/transient-prompt.plugin.zsh
do
    [[ -f $_p ]] && source $_p
done; unset _p

TRANSIENT_PROMPT_TRANSIENT_PROMPT='$(starship prompt --profile transient)'

[[ -f ~/.config/am/aliases.txt ]] && source ~/.config/am/aliases.txt
command -v scw >/dev/null && eval "$(scw autocomplete script shell=zsh)"
