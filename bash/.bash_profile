> "$HOME/.bash_history" && history -c

if [ -f "$HOME/.bashrc" ]
then
	. "$HOME/.bashrc"
fi

if [ -f "$HOME/.profile" ]
then
	. "$HOME/.profile"
fi

[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
