> "$HOME/.bash_history" && history -c

[ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
[ -f "$HOME/.profile" ] && . "$HOME/.profile"

[ -f "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -f "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

[ -d "$RBENV_DIR" ] && eval "$("$RBENV_DIR/bin/rbenv" init - --no-rehash bash)"
