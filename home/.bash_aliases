alias pn="pnpm"

mkcd()
{
	mkdir "$1" || return
	cd "$1"
}
