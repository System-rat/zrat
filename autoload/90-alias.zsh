alias ls="ls --color=auto"
alias ll="ls -alhF"
alias help="run-help"
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# git
alias gis='git status'
alias gic='git commit'
alias gica='git commit --amend'
alias gir='read -q "choice?Restore entire folder? [y/n]" && git restore .'
alias gia='git add'
alias gipl='git pull'
alias gipu='git push'
alias gil='git log'
alias REE_STOP_FUCKING_AROUND='git stash && git pull && git stash pop'
alias reload='source ~/.zshrc'
