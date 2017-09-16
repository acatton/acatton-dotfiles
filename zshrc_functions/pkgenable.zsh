#!/usr/bin/env zsh

PKGS_PATH="$HOME/.pkgs"

pkgenable() {
    case $1 in
        rust|cargo)
            P="$PKGS_PATH/rust/"
            export RUSTUP_HOME="$P/rustup/"
            export CARGO_HOME="$P/cargo/"
            export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$P/lib/"
            export PATH="$PATH:$P/bin/:$CARGO_HOME/bin"
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
        cabal|haskell|stack)
            PATH="$PKGS_PATH/haskell/bin:$HOME/.cabal/bin/:$PATH:$PWD/.cabal-sandbox/bin/"
            ;;
        otp|erlang|rebar)
            export PATH="$PKGS_PATH/erlang/bin:$PATH"
            ;;
        npm|node)
            export PATH="$PKGS_PATH/node/bin:$PATH"
            ;;
        nodemodules|npmmodules|localnode)
            export PATH="$PWD/node_modules/.bin:$PATH"
            ;;
        phantom|phantomjs)
            export PATH="$PATH:$PKGS_PATH/phantomjs/bin/"
            ;;
        scala|sbt)
            export PATH="$PKGS_PATH/scala/bin:$PATH"
            ;;
        *)
            echo "No such package"
            return 127
            ;;
    esac
}
