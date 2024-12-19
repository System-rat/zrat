for f in ~/.zsh/utils/*.zsh; do
  source $f
done

__rat_profile_start 'init'

for file in ~/.zsh/autoload/*.zsh(n.on); do
  __rat_debug "Sourcing file: ::file::" "$(basename $file)"
  __rat_profile_start "source: $(basename $file)"
  source $file
  __rat_profile_end
done

__rat_profile_end
