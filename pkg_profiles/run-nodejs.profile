include /home/antoine/Dev/dotfiles/pkg_profiles/base_pkgs.inc
include /home/antoine/Dev/dotfiles/pkg_profiles/common-nodejs.inc

env CUSTOM_FIREJAIL_ENV=nodejs
env CUSTOM_FIREJAIL_PATH=/home/antoine/.pkgs/nodejs/npm/bin:/home/antoine/.pkgs/nodejs/node/bin

read-only ${HOME}/.pkgs/nodejs/
read-write ${HOME}/.pkgs/nodejs/cache
