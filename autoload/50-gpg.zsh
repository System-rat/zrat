if [[ ${+commands[gpg]} == 1 ]] &&
  [[ ${+commands[gpg-connect-agent]} == 1 ]] &&
  [[ ${+commands[gpgconf]} == 1 ]] {

  export GPG_TTY=$(tty)
  unset SSH_AGENT_PID

  if [[ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]] {
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
  }

  gpg-connect-agent updatestartuptty /bye >/dev/null
}
