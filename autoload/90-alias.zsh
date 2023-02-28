(( $+commands[lsd] )) && alias ls="lsd" || alias ls="ls --color=auto"
(( $+commands[lsd] )) && alias ll="lsd -alhF" || alias ll="ls -alhF"
alias help="run-help"
(( $+commands[notify-send] )) && alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
if (( $+commands[fdfind] )); then
  alias fd="fdfind"
  alias find="fdfind"
fi

if [[ $TERM == "xterm-kitty" ]]; then
  alias ssh="kitty +kitten ssh"
fi

# git
alias gis='git status'
alias gid='git diff'
alias gidt='git difftool'
alias gif='git fetch'
alias gic='git commit'
alias gica='git commit --amend'
alias gir='read -q "choice?Restore entire folder? [y/n]" && git restore .'
alias gia='git add'
alias gipl='git pull'
alias gipu='git push'
alias gil='git log'
alias giw='git switch'
alias REE_STOP_FUCKING_AROUND='git stash && git pull && git stash pop'
alias I_SAID_PUSH_THE_DAMN_BRANCH='git push --force'
alias reload='source ~/.zshrc'
alias reload_hard='exec -l zsh'
alias tarit='tar --zstd -cf $(read -e "?File name: ")-$(date +%Y-%m-%d--%H-%M).tar.zst'
alias zipit='zip -r $(read -e "?File name: ")-$(date +%Y-%m-%d--%H-%M).zip'
