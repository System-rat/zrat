# Options
HISTFILE=~/.zhistfile
HISTSIZE=2000
SAVEHIST=2000
setopt extendedglob nomatch
unsetopt autocd beep notify
bindkey -e
autoload -U select-word-style
select-word-style bash
export WORDCHARS=''

fpath+=(~/.zsh/autoload/[0-9]*(/Non))

for dir in ~/.zsh/autoload/[0-9]*(/Non)
do
  [[ -n $__rat_debug ]] && echo "Autoloading $dir..."
  autoload -U $dir/*(.:t:r)
done
