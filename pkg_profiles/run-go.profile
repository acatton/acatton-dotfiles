include /home/antoine/Dev/perso/dotfiles/pkg_profiles/base_pkgs.inc
include /home/antoine/Dev/perso/dotfiles/pkg_profiles/common-go.inc

env CUSTOM_FIREJAIL_ENV=go
env CUSTOM_FIREJAIL_PATH=/home/antoine/.pkgs/go/dist/bin:/home/antoine/.pkgs/go/workspace/bin

read-write ${HOME}/.pkgs/go/workspace/pkg/mod/
read-write ${HOME}/.pkgs/go/workspace/pkg/sumdb/
read-write ${HOME}/.pkgs/go/cache/

allow-debuggers