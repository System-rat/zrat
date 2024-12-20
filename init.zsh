for f in ~/.zsh/utils/*.zsh; do
  source $f
done
unset f

__rat_profile_start 'init'

for file in ~/.zsh/autoload/*.zsh(n.on); do
  __rat_debug "Sourcing file: ::file::" "$(basename $file)"
  __rat_profile_start "source: $(basename $file)"
  source $file
  __rat_profile_end
done
unset file

__rat_profile_end
