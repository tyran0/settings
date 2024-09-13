alias pn="pnpm"

mkcd()
{
	[ -z "$1" ] && return 1
	
	mkdir "$1"
	cd "$1"

	return 0
}
