#!/usr/bin/bash

SCRIPT_SRC="$(dirname "$(realpath "$0")")"

symlinks_count=0
symlink_display_target_prefix=""

setup_symlink_catch_incorrect_target()
{
	[ ! -L "$destination" ] && return 1
	
	echo "Target path is incorrect"

	rm "$destination"
}

setup_symlink_catch_not_a_symlink()
{
	local date_now="$(date +%H:%M_%d_%m_%Y)"
	
	[ ! -f "$destination" ] && return 1
		
	echo "This is not a symbolic link"
		
	cp "$destination" "$destination.$date_now.bak"
	echo "Created a backup '$destination.$date_now.bak'"
		
	rm "$destination"
}

setup_symlink()
{	
	local filename="$1"
	local target="$2/$filename"
	local destination="$3/$filename"
	local display_target="$symlink_display_target_prefix/$filename"
	local should_be_fixed=0

	let "symlinks_count++"
	
	[ $symlinks_count -gt 1 ] && printf "\n"
	
	echo "Checking symbolic link:"
	echo "[ $display_target -> ${destination/$HOME/\~} ]"

	if [ -L "$destination" ] \
	&& [ "$(realpath "$destination")" = "$target" ]; then
		echo "Nothing to do"

		return
	fi

	setup_symlink_catch_incorrect_target && should_be_fixed=1
	setup_symlink_catch_not_a_symlink && should_be_fixed=1
	
	ln -s "$target" "$destination"
	
	if (( $should_be_fixed )); then
		echo "Fixed!"
	else
		echo "Created symbolic link!"
	fi
}

for filename in \
	.bash_aliases \
	.bash_profile \
	.profile \
	.irbrc
do
	symlink_display_target_prefix="~/settings/home"
	
	setup_symlink "$filename" "$SCRIPT_SRC/home" "$HOME"
done

symlink_display_target_prefix="~/settings"

[ -z "$XDG_CONFIG_HOME" ] && XDG_CONFIG_HOME="$HOME/.config"

setup_symlink "git/config" "$SCRIPT_SRC" "$XDG_CONFIG_HOME"

printf "\nDone!\n"
