include /home/antoine/Dev/dotfiles/pkg_profiles/base_pkgs.inc
include /home/antoine/Dev/dotfiles/pkg_profiles/common-nodejs.inc

read-write ${HOME}/.pkgs/nodejs/

env PATH=/home/antoine/.pkgs/nodejs/npm/bin:/home/antoine/.pkgs/nodejs/node/bin:/usr/bin:/usr/local/bin
