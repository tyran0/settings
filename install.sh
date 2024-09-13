#!/usr/bin/bash

SCRIPT_DIR="$(dirname "$(realpath "$0")")"

setup_symlink()
{	
	local target="$1"
	local link="$2"

	if [ -L "$link" ] && [ "$(realpath "$link")" = "$target" ]
	then
		echo "Target path of symbolic link '$link' is correct. Leaving"

		return 0
	fi

	if [ -f "$link" ]
	then
		cp "$link" "$link.old"
		rm "$link"

		echo "'$link' is a not a symbolic link. Fixing"
	fi

	ln -s "$target" "$link"
	
	echo "Created symbolic link '$link' pointing to '$target'"

	return 0
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
