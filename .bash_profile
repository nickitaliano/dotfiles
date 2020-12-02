PATH="/usr/local/bin:$PATH"
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
# [ -s "$HOME/.asdf/asdf.zsh" ] && . "$HOME/.asdf/asdf.zsh"
# [ -s "$HOME/.asdf/completions/asdf.bash" ] && . "$HOME/.asdf/completions/asdf.bash"
[[ -s `brew --prefix`/etc/asdf.zsh ]] && . `brew --prefix`/etc/asdf.zsh

# . /usr/local/opt/asdf/asdf.sh
# . /usr/local/opt/asdf/etc/bash_completion.d/asdf.bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
