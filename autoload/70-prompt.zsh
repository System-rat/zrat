__rat_col() {
  local arg=$1
  local fcol=$2
  local bcol=$3
  local res=""

  res+="%F{$fcol}"
  res+="%K{$bcol}"
  res+=$arg
  res+="%k"
  res+="%f"

  echo $res
}

__rat_fa() {
  echo $(__rat_col "" $1 $2)
}

__rat_ba() {
  echo $(__rat_col "" $1 $2)
}

#PROMPT=$(__rat_col "%B%n%M: " cyan black)
#PROMPT+=$(__rat_col "%~ " blue black)
#PROMPT+="%(?.."$(__rat_col " " red black)$(__rat_ba red black)$(__rat_col "ERR %?" white red)$(__rat_fa red black)")"
#PROMPT+="$(__rat_fa black default)%b "

# TODO: FIX THIS ABHORRENT MESS

PROMPT="%B%K{black}%(!.%F{red}.%F{cyan})%n@%M%f%b:%B%F{blue}%~%f %(?..%F{red}%K{black}%k%f%F{white}%K{red}ERR %?%k%f%F{red}%K{black}%k%f%K{black} %k)%k%F{black}%f%b "
PROMPT2="%B%K{black}%F{cyan}%_%f%k%F{black}%f%b "
PROMPT3="%B%K{black}%F{cyan}select answer: %f%k%F{black}%f%b "
PROMPT4="%B%K{black}%F{red}+%N: %i%f%k%F{black}%f%b "
