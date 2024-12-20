# Options
HISTFILE=~/.zhistfile
HISTSIZE=10000
SAVEHIST=10000
setopt extendedglob nomatch
unsetopt autocd beep notify
bindkey -e
autoload -U select-word-style
select-word-style bash
export WORDCHARS=''

fpath+=(~/.zsh/autoload/[0-9]*(/nNon))

for dir in ~/.zsh/autoload/[0-9]*(/nNon)
do
  [[ -n $__rat_debug ]] && echo "Autoloading $dir..."

  local files=($dir/*(nN.:t:r))
  [[ "$dir" =~ '\.zle(\..*)?$' ]]
  local is_zle=$?

  if [[ $#files != 0 ]]; then
    autoload -U $dir/*(.:t:r)
    if [[ $is_zle -eq 0 ]]; then
      for widget in $dir/*(.:t:r)
      do
        zle -N $widget
      done
    fi
  fi
done
unset dir
