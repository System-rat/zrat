__rat_profile_current_level=0
typeset -a __rat_profile_context __rat_profile_start_time

zmodload zsh/datetime

function __rat_profile_start() {
  __rat_profile_current_level=$(( __rat_profile_current_level + 1 ))
  __rat_profile_context[$__rat_profile_current_level]="${1:-(unknown)}"
  __rat_profile_start_time[$__rat_profile_current_level]=$EPOCHREALTIME
}

function __rat_profile_end() {
  local end_time start_time context

  if [[ $__rat_profile_current_level -eq 0 ]]; then
    __rat_error "Profiler ended without starting!"
    return 1
  fi

  start_time=$__rat_profile_start_time[$__rat_profile_current_level]
  context=$__rat_profile_context[$__rat_profile_current_level]
  end_time=$EPOCHREALTIME

  __rat_trace "'::context::' took ::time::ms to complete"\
    "$context" $(( (end_time - start_time) * 1000 ))

  unset "__rat_profile_start_time[$__rat_profile_current_level]"
  unset "__rat_profile_context[$__rat_profile_current_level]"
  __rat_profile_current_level=$(( __rat_profile_current_level - 1 ))
}
