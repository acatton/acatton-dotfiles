#!/usr/bin/env zsh

PKGS_PATH="$HOME/.pkgs"

pkgenable() {
    case $1 in
        rust|cargo)
            P="$PKGS_PATH/rust/"
            export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$P/lib/"
            export PATH="$PATH:$P/bin/"
            ;;
        ocaml|opam)
            P=$(ls -1 "$PKGS_PATH"/ocaml/*/etc/ocamlbrew.bashrc | sort -r | head -n 1)
            source $P
            ;;
        ruby|rail|rvm)
            P="$PKGS_PATH/rvm"
            export rvm_path=$P
            source "$P/scripts/rvm"
            ;;
        cabal|haskell)
            PATH=$HOME/.cabal/bin/:$PATH:$PWD/.cabal-sandbox/bin/
            ;;
        otp|erlang|rebar)
            export PATH="$HOME/.pkgs/erlang/bin:$PATH"
            ;;
        npm|node)
            export PATH="$HOME/.pkgs/node/bin:$PATH"
            ;;
        *)
            echo "No such package"
            return 127
            ;;
    esac
}
