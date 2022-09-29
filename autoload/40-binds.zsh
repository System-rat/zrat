bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
bindkey "^H" backward-delete-word
bindkey "^[[3~" delete-char
bindkey "^[[3;5~" delete-word

zle -N __rat_open_in_man
bindkey "^[m" __rat_open_in_man
