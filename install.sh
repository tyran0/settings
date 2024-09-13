#!/usr/bin/bash

SCRIPT_DIR="$( dirname -- "$( realpath -- "$0" )" )"

setup_symlink()
{	
	local target="$1"
	local link="$2"

	if [ -L "$link" ] && [ $( realpath "$link" ) = "$target" ]
	then
		echo "Nothing to do! Target path of symbolic link '$link' is correct"

		return 0
	fi

	if [ -f "$link" ]
	then
		cp "$link" "$link.backup"

		echo "'$link' is a not a symbolic link! Created a backup before fixing"
	fi

	[ -e "$link" ] && rm "$link"
	ln -s "$target" "$link"

	echo "Created symbolic link '$link' pointing to '$target'"
}

for file_name in \
	.bash_aliases \
	.bash_profile \
	.profile
do
	setup_symlink "$SCRIPT_DIR/bash/$file_name" "$HOME/$file_name"
done

[ -z "$XDG_CONFIG_HOME" ] && XDG_CONFIG_HOME="$HOME/.config"

setup_symlink "$SCRIPT_DIR/git/config" "$XDG_CONFIG_HOME/git/config"

echo Done!
