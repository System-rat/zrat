(( $+commands[lsd] )) && alias ls="lsd" || alias ls="ls --color=auto"
(( $+commands[lsd] )) && alias ll="lsd -AlhF" || alias ll="ls -AlhF"
alias help="run-help"
(( $+commands[notify-send] )) && alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
if (( $+commands[fdfind] )); then
  alias fd="fdfind"
  alias find="fdfind"
fi

# Kitty fixes
if [[ $TERM == "xterm-kitty" ]]; then
  if command -v kitty > /dev/null && [[ -n $KITTY_WINDOW_ID ]]; then
    alias ssh="kitty +kitten ssh"
    alias cati="kitty +kitten icat"
  fi

  # lnav really doesn't like things not being xterm
  alias lnav="TERM=xterm-256color lnav"
fi

(( $+commands[bat] )) && alias cat="bat"
# Debian compat
(( $+commands[batcat] )) && alias cat="batcat"

if (( $+commands[udisksctl] )); then
  alias mntdisk='udisksctl mount -b'
  alias umntdisk='udisksctl unmount -b'
fi

# git
alias gis='git status -sb'
alias gid='git diff --word-diff=color'
alias gids='git diff --word-diff=color --staged'
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
alias gilg='git log --all --decorate --oneline --graph'
alias REE_STOP_FUCKING_AROUND='git stash && git pull && git stash pop'
alias I_SAID_PUSH_THE_DAMN_BRANCH='git push --force'

# Nix specific

if (( $+commands[nix] )); then
  alias nib="nix-build --log-format bar-with-logs"
  alias nis="nix-shell --log-format bar-with-logs"
fi

if (( $+commands[nixos-rebuild] )); then
  alias nos-rs="sudo nixos-rebuild switch"
  alias nos-rsu="sudo nixos-rebuild switch --upgrade"
fi

# Extras
alias reload='exec -l zsh'
alias tarit='tar --zstd -cf $(read -e "?File name: ")-$(date +%Y-%m-%d--%H-%M).tar.zst'
alias zipit='zip -r $(read -e "?File name: ")-$(date +%Y-%m-%d--%H-%M).zip'
