#!/usr/bin/bash

SCRIPT_DIR="$( dirname -- "$( realpath -- "$0" )" )"

update_or_create_symlink()
{	
	local file="$1"
	local target_dir="$2"
	local target="$target_dir/$file"
	local link_dir="$3"
	local link="$link_dir/$file"

	if [ -z "$file" ]
	then
		echo Cannot create symbolic link! 1st parameter \'file\' is missing or not defined
		return 3
	fi

	if [ -z "$target_dir" ]
	then
		echo Cannot create symbolic link! 2nd parameter \'target_dir\' is missing or not defined
		return 3
	fi

	if [ -z "$link_dir" ]
	then
		echo Cannot create symbolic link! 3rd parameter \'link_dir\' is missing or not defined
		return 3
	fi

	for dir in \
		"$target_dir" \
		"$link_dir"
	do
		[ -d "$dir" ] && continue
		
		echo Cannot create symbolic link! Directory \'$dir\' does not exist
		return 2
	done

	if [ ! -f "$target" ]
	then
		echo Cannot create symbolic link! File \'$target\' does not exist
		return 2
	fi

	if [ -L "$link" ] && [ $( realpath "$link" ) = "$target" ]
	then
		echo Skipping \'$link\', because it\'s a valid symbolic link!
		return 1
	fi

	if [ -f "$link" ]
	then
		echo Skipping \'$link\', because it\'s a regular file!
		return 1
	fi

	[ -e "$link" ] && rm "$link"
	ln -s "$target" "$link"
	echo Created symbolic link \'$link\' pointing to \'$target\'!
}

for file in \
	.bash_aliases \
	.bash_profile \
	.profile
do
	update_or_create_symlink "$file" "$SCRIPT_DIR/bash" "$HOME"
done

[ -z "$XDG_CONFIG_HOME" ] && XDG_CONFIG_HOME="$HOME/.config"

update_or_create_symlink "config" "$SCRIPT_DIR/git" "$XDG_CONFIG_HOME/git"

echo Done!
