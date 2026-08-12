[[ $- != *i* ]] && return

[[ -f /usr/share/omarchy-zsh/shell/zoptions ]] && source /usr/share/omarchy-zsh/shell/zoptions
[[ -f /usr/share/omarchy-zsh/shell/all ]] && source /usr/share/omarchy-zsh/shell/all
[[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -f /usr/share/zsh/plugins/zsh-transient-prompt/transient-prompt.plugin.zsh ]] && source /usr/share/zsh/plugins/zsh-transient-prompt/transient-prompt.plugin.zsh

TRANSIENT_PROMPT_TRANSIENT_PROMPT='$(starship prompt --profile transient)'

[[ -f ~/.config/am/aliases.txt ]] && source ~/.config/am/aliases.txt
command -v scw >/dev/null && eval "$(scw autocomplete script shell=zsh)"
