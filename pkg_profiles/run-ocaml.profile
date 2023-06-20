include /home/antoine/Dev/perso/dotfiles/pkg_profiles/base_pkgs.inc
include /home/antoine/Dev/perso/dotfiles/pkg_profiles/common-ocaml.inc

env CUSTOM_FIREJAIL_ENV=ocaml
env CUSTOM_FIREJAIL_PATH=/home/antoine/.pkgs/ocaml/bin:/home/antoine/.pkgs/ocaml/root/default/bin

env OPAM_SWITCH_PREFIX=/home/antoine/.pkgs/ocaml/root/default
env CAML_LD_LIBRARY_PATH=/home/antoine/.pkgs/ocaml/root/default/lib/stublibs:/home/antoine/.pkgs/ocaml/root/default/lib/ocaml/stublibs:/home/antoine/.pkgs/ocaml/root/default/lib/ocaml
env OCAML_TOPLEVEL_PATH=/home/antoine/.pkgs/ocaml/root/default/lib/toplevel

# TODO: We should use the same technique as for PATH (= CUSTOM_FIREJAIL_MANPATH)
env MANPATH=/home/antoine/.pkgs/ocaml/root/default/man

read-write ${HOME}/.pkgs/ocaml/root
