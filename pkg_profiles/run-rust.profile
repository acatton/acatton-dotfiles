include /home/antoine/Dev/perso/dotfiles/pkg_profiles/base_pkgs.inc
include /home/antoine/Dev/perso/dotfiles/pkg_profiles/common-rust.inc

env CUSTOM_FIREJAIL_ENV=rust
env CUSTOM_FIREJAIL_PATH=/home/antoine/.pkgs/rust/cargo/bin:/home/antoine/.pkgs/rust/bin

read-write /home/antoine/.pkgs/rust/cargo/registry/
read-write /home/antoine/.pkgs/rust/cargo/credentials

allow-debuggers
