# Default log level
: ${__rat_level=INFO}

# Order of levels
local -A __rat_level_order
__rat_level_order=(
  CRITICAL 0
  ERROR    1
  WARNING  2
  INFO     3
  DEBUG    4
  TRACE    5
)

function __rat_msg() {
  local level=$1
  local msg=$2
  shift; shift

  local args=($@)

  if [[ $__rat_level_order[$level] -gt $__rat_level_order[$__rat_level] ]]; then
    return
  fi

  local label

  case $level in
    CRITICAL)
      label="\e[1;31m[rat::CRITICAL]\e[0m"
      ;;
    ERROR)
      label="\e[1;31m[rat::ERROR]\e[0m"
      ;;
    WARNING)
      label="\e[1;33m[rat::WARNING]\e[0m"
      ;;
    INFO)
      label="\e[1;34m[rat::INFO]\e[0m"
      ;;
    # DEBUG and TRACE have timestamps
    DEBUG)
      label="[$(date '+%Y-%m-%d %H:%M:%S.%N')] \e[1;32m[rat::DEBUG]\e[0m"
      ;;
    TRACE)
      label="[$(date '+%Y-%m-%d %H:%M:%S.%N')] \e[1;30m[rat::TRACE]\e[0m"
      ;;
    esac

    local final_msg="$msg"

    # Go through every additional argument and substitute ::[name]:: with the argument.
    # [name] is arbitrary since the substitution is order based. If the replacement string
    # contains ::[name]:: the replacement breaks TODO: fix
    for arg in $args; do
      final_msg=$(echo $final_msg | sed "s/::[^:]*::/$arg/")
    done

    print $label $final_msg
}


function __rat_critical() {
  __rat_msg CRITICAL $@
}

function __rat_error() {
  __rat_msg ERROR $@
}

function __rat_warning() {
  __rat_msg WARNING $@
}

function __rat_info() {
  __rat_msg INFO $@
}

function __rat_debug() {
  __rat_msg DEBUG $@
}

function __rat_trace() {
  __rat_msg TRACE $@
}
