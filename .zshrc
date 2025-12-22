#historial
HISTFILE=~/.zsh_historial
HISTSIZE=1000
SAVEHIST=1000
setopt INC_APPEND_HISTORY_TIME

#Bindings
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Alias 
alias ll="ls -al"

#Comandos a ejecutar
eval $(thefuck --alias)
eval "$(starship init zsh)"

