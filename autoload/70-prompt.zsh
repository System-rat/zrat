: ${__rat_fore:="white"}
: ${__rat_back:="#5F3B80"}
local __ratp="PROMPT"

function __ratpu() {
  : ${(P)__ratp::="${(P)__ratp}"$@}
}

function __ratcol() {
  case $1 in
    fg)
      __ratpu "%F{"$2"}"
      ;;
    bg)
      __ratpu "%K{"$2"}"
      ;;
    *)
      echo __ratcol: $(ansi bold red)No such identifier $1
      ;;
  esac
}

function __ratcolwr() {
  __ratcol $1 $2
  shift; shift
  __ratpu $@
  __ratcol fg $__rat_fore
  __ratcol bg $__rat_back
}

function __rat_begin_prompt() {
  alias fa="__ratpu "
  alias ba="__ratpu "
  alias fore="__ratcol fg"
  alias forer="__ratpu '%f'"
  alias wfore="__ratcolwr fg"
  alias wback="__ratcolwr bg"
  alias back="__ratcol bg"
  alias backr="__ratpu '%k'"
  alias iden="__ratpu"
  alias bold="__ratpu '%B'"
  alias boldr="__ratpu '%b'"
  alias end_prompt="__ratpu '%f%k%b'"
}

function __rat_end_prompt() {
  unalias fa ba fore forer wfore wback back backr iden end_prompt bold boldr
}

__rat_begin_prompt

function __rat_build_error() {
  iden "%(?.."
  fore red; ba
  fore white
  back red
  iden "ERR %?"
  fore red
  back $__rat_back
  fa
  fore $__rat_fore
  iden " )"
}

function __rat_build_prompt1 {
  PROMPT=""
  __ratp="PROMPT"
  fore $__rat_fore
  back $__rat_back

  bold
  iden "%n@%M"
  boldr
  wfore white ":"
  bold
  wfore blue "%~ "

  __rat_build_error

  fore $__rat_back
  backr
  fa
  end_prompt
  iden " "
}

function __rat_simple_prompt {
  local _fore=$1
  local _back=$2
  shift; shift
  fore $_fore
  back $_back
  bold

  iden "$@"
  fore $_back
  backr
  fa
  iden " "
  end_prompt
}

function __rat_build_prompt2 {
  PROMPT2=""
  __ratp="PROMPT2"
  __rat_simple_prompt $__rat_fore $__rat_back '%_ '
}

function __rat_build_prompt3 {
  PROMPT3=""
  __ratp="PROMPT3"

  __rat_simple_prompt $__rat_fore $__rat_back 'select answer: '
}

function __rat_build_prompt4 {
  PROMPT4=""
  __ratp="PROMPT4"
  __rat_simple_prompt red white '+%N: %i'
}

setopt promptsubst

__rat_build_prompt1
__rat_build_prompt2
__rat_build_prompt3
__rat_build_prompt4

__rat_end_prompt

preexec() {
  __rat_executing=1
  __rat_time=$(date +%s%3N)
}

precmd() {
  if [[ $__rat_executing == 1 ]] && [[ -n $__rat_time ]]; then
    local t=$(( $(date +%s%3N) - $__rat_time ))

    if (( $t > 1000 )); then
      RPROMPT="%F{black}($(readable time -m $t))%f"
    else
      RPROMPT=""
    fi
  else
    RPROMPT=""
  fi

  __rat_executing=0
}

