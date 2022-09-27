for file in ~/.zsh/autoload/*.zsh(.on); do
  [[ -n $__rat_debug ]] && echo "Sourcing $file..."
  source $file
done
