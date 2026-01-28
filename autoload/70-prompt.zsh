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
  alias fa="if [[ $TERM != 'linux' ]] { __ratpu  }"
  alias ba="if [[ $TERM != 'linux' ]] { __ratpu  }"
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

functions __rat_shlvl() {
  if (( $SHLVL > 1 )); then
    echo "lvl $SHLVL"
  fi
}

function __rat_build_prompt1_venv {
  back $__rat_venv_color
  fore $__rat_back

  bold
  iden " $__rat_venv "
  boldr

  fore "$__rat_venv_color"
  back $__rat_back
  fa
  forer
  backr
}

function __rat_build_prompt1 {
  PROMPT=""
  __ratp="PROMPT"

  local shlvl="$(__rat_shlvl)"

  if [[ -n $shlvl ]]; then
    back "#3f3f3f"
    fore "#ffffff"
    iden " $shlvl "
    fore "#3f3f3f"
    back $__rat_back
    fa
    forer
    backr
  fi

  # venv setup
  if [[ -n $__rat_venv ]]; then
    __rat_build_prompt1_venv
  fi

  fore $__rat_fore
  back $__rat_back

  bold
  wfore '#87FFFC' '$__rat_pwd '
  fore $__rat_back
  backr
  fa
  forer
  iden $'\n'

  fore $__rat_fore
  back $__rat_back
  bold
  iden " %(!.%F{red}.)%n%(!.%f.)@%m"
  boldr
  wfore white ": "

  bold
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

function __rat_build_rprompt {
  # Remove redundant indent at the end
  ZLE_RPROMPT_INDENT=0
  __rat_rprompt=""
  __ratp="__rat_rprompt"
  fore $__rat_back
  ba
  fore $__rat_fore
  back $__rat_back
  iden ' $__rat_time '

  forer
  backr
  end_prompt
}

setopt promptsubst

__rat_build_prompt1
__rat_build_prompt2
__rat_build_prompt3
__rat_build_prompt4
__rat_build_rprompt

__rat_end_prompt

preexec() {
  __rat_executing=1
  __rat_time=$(date +%s%3N)
}

precmd() {
  local cur_t=$(date +%s%3N)
  if [[ $__rat_executing == 1 ]] && [[ -n $__rat_time ]]; then
    local t=$(( $cur_t - $__rat_time ))
    if (( $t > 1000 )); then
      __rat_time=$(readable time -m $t)
      RPROMPT=$__rat_rprompt
    else
      RPROMPT=""
    fi
  else
    RPROMPT=""
  fi
  __rat_executing=0
  __rat_virt_env_check
}

function __rat_set_pwd() {
  if [[ $TERM != "linux" ]]; then
    __rat_pwd=" "${(j:  :)${(s:/:)PWD/"${HOME}"/'~'}:-/}
  else
    __rat_pwd=" "${(j:/:)${(s:/:)PWD/"${HOME}"/'~'}:-/}
  fi
}

__rat_set_pwd

chpwd() {
  __rat_set_pwd
}

