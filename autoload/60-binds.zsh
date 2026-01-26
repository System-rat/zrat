bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
bindkey "^H" backward-delete-word
bindkey "^[[3~" delete-char
bindkey "^[[3;5~" delete-word

bindkey -M menuselect "^[[Z" reverse-menu-complete

bindkey "^[m" rat-open-in-man
(( $+commands[fzf] )) && bindkey "^R" rat-history
