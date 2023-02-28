function command_not_found_handler() {
  if ! (( $+commands[pkgfile] ))
  then
    printf 'command not found: %s\n' "$1"
    return 127
  fi
  local pkg cmd="$1"

  pkgs=(${(f)"$(pkgfile -b -v -- "$cmd" 2>/dev/null)"})
  if [[ ${#pkgs} -eq 1 ]]
  then
    choices=(
      "install"
      "cancel"
      "re-run"
    )
    pkg=${pkgs[1]%% *}
    case $(rat_menu $choices) in
      install)
        sudo pacman -S --noconfirm -- "$pkg"
        printf 'package installed %s\n' "$pkg"
        return 127
        ;;
      cancel)
        return 127
        ;;
      re-run)
        printf 'not implemented\n'
        return 127
        ;;
    esac
  elif [[ -n "$pkgs" ]]
  then
    printf '%s may be found in the following packages:\n' "$cmd"
    printf '  %s\n' ${pkgs[@]}
    return 127
  else
    printf 'command not found: %s\n' "$cmd"
    return 127
  fi
}
