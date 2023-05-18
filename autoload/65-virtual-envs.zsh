# ### Python virtualenv
# disable virtualenv prompt for our own since it sucks
# NOTE: this will disable it for every activation
export VIRTUAL_ENV_DISABLE_PROMPT=1

# inside the virtual env, populate the prompt variable
function __rat_virt_env_check() {
  if [[ -n $VIRTUAL_ENV ]]; then
    local ident="$(cat $VIRTUAL_ENV/pyvenv.cfg | sed -n 's/^\s*prompt\s*=\s*\(.*\)\s*$/\1/p')"
    __rat_venv="$ident "
    __rat_venv_color="yellow"

    # reload the prompt
    . ~/.zsh/autoload/70-prompt.zsh
  else
    __rat_venv=""
    __rat_venv_color=""

    # reload the prompt
    . ~/.zsh/autoload/70-prompt.zsh
  fi
}
