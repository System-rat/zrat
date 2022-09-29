# TODO: FIX THIS ABHORRENT MESS

PROMPT="%B%K{black}%(!.%F{red}.%F{cyan})%n@%M%f%b:%B%F{blue}%~%f %(?..%F{red}%K{black}%k%f%F{white}%K{red}ERR %?%k%f%F{red}%K{black}%k%f%K{black} %k)%k%F{black}%f%b "
PROMPT2="%B%K{black}%F{cyan}%_%f%k%F{black}%f%b "
PROMPT3="%B%K{black}%F{cyan}select answer: %f%k%F{black}%f%b "
PROMPT4="%B%K{black}%F{red}+%N: %i%f%k%F{black}%f%b "

preexec() {
  __rat_executing=1
  __rat_time=$(date +%s%3N)
}

precmd() {
  if [[ $__rat_executing == 1 ]] && [[ -n $__rat_time ]]; then
    local t=$(( $(date +%s%3N) - $__rat_time ))

    if (( $t > 1000 )); then
      RPROMPT="%F{black}($(( $t / 1000 )).$(( $t % 1000 ))s)%f"
    else
      RPROMPT=""
    fi
  else
    RPROMPT=""
  fi

  __rat_executing=0
}

