# ~/.zshrc - portable across macOS, Linux, WSL. Self-contained: no distro
# package required. Everything below degrades gracefully if a tool is absent.
[[ $- != *i* ]] && return

# History
HISTFILE=~/.zsh_history
HISTSIZE=32768
SAVEHIST=32768
setopt APPEND_HISTORY SHARE_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS \
    HIST_IGNORE_SPACE HIST_REDUCE_BLANKS HIST_VERIFY

# Shell behaviour
setopt AUTO_CD EXTENDED_GLOB INTERACTIVE_COMMENTS
unsetopt BEEP

# Emacs keybindings; Up/Down search history by the prefix already typed
bindkey -e
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search    # Up
bindkey '^[[B' down-line-or-beginning-search  # Down
bindkey '^[OA' up-line-or-beginning-search    # Up   (application mode)
bindkey '^[OB' down-line-or-beginning-search  # Down (application mode)

# Completion: case-insensitive, colored, highlighted menu
autoload -Uz compinit && compinit -i
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select
[[ -n $LS_COLORS ]] && zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Optional plugins: load from whichever path the system installed them to
# (Arch/omarchy, Homebrew Intel + Apple Silicon, Debian/Ubuntu). Syntax
# highlighting must be sourced last.
for _p in \
    /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh \
    /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh \
    /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh \
    /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh \
    /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
    /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
    /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
    /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
do
    [[ -r $_p ]] && source $_p
done
unset _p

# Aliases
[[ -f ~/.config/am/aliases.txt ]] && source ~/.config/am/aliases.txt

# Prompt
command -v starship >/dev/null && eval "$(starship init zsh)"

# Tool completions, only when the tool is installed
command -v scw >/dev/null && eval "$(scw autocomplete script shell=zsh)"
