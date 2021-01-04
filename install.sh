#!/usr/bin/env bash
set -e

PROJECT_DIRECTORY=$(readlink -f $(dirname "${BASH_SOURE[0]}"))

FILES=$(ls -1 "$PROJECT_DIRECTORY" | egrep -v "^(install.sh|README.md)$")

for f in $FILES
do
	f=$(readlink -f "$f")
	fbasename=$(basename "$f")
	# Only override symlinks
	target="${HOME}/.${fbasename}"
	if [ -h "$target" ] && ( !( readlink -f "$target" > /dev/null ) || [ "x$(readlink -f "$target")" != "x$(readlink -f "$f")" ] )
	then
		unlink "$target"
	fi

	if [ ! -e "$target" ]
	then
		ln -s "$f" "$target"
	fi
done

mkdir -p "${HOME}/.gitconfig.d/"
mkdir -p "${HOME}/.hgrc.d/"
