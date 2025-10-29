# ~/.zshrc — minimal, fast, clean

# ---- History ----
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY SHARE_HISTORY

# ---- Completion ----
autoload -Uz compinit && compinit

# ---- Options ----
setopt autocd           # cd by typing folder name
setopt correct          # autocorrect small typos in commands
setopt extendedglob     # advanced pattern matching
setopt prompt_subst     # allow prompt commands (needed for starship)
setopt interactivecomments  # allow # comments in interactive shell

# ---- Aliases ----
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -lAh'
alias vim='nvim'
# alias nf='fzf --preview="bat --color=always {}" --bind "enter:become(nvim {+})"'
alias inv='nvim $(fzf --preview="bat --color=always {}")' 
# ---- Prompt (temporary; will be replaced by Starship) ----
PROMPT='%F{green}%n@%m%f %F{blue}%~%f %# '

eval "$(starship init zsh)"
source <(fzf --zsh)

# Load built-in completion system

zstyle ':autocomplete:*' auto-expand 'false'
zstyle ':autocomplete:*' inline-menu 'false'
 
autoload -Uz compinit
compinit
compaudit

# Load zsh plugins
# zsh-autocomplete should come early, after compinit
# Before sourcing zsh-autocomplete
source /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# Optional extras
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


ZSH_AUTOSUGGEST_DELAY=0.3 # delay in seconds (0.3 = 300ms)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'  # subtle grey

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# bindkey '^I' autosuggest-accept
#
#
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5A' up-line-or-history
bindkey '^[[1;5B' down-line-or-history
