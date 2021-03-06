#!/usr/bin/env zsh

PKGS_PATH="$HOME/.pkgs"

pkgenable() {
    case $1 in
        rust|cargo)
            P="$PKGS_PATH/rust/"
            export RUSTUP_HOME="$P/rustup/"
            export CARGO_HOME="$P/cargo/"
            source "$P/cargo/env"
            ;;
        ocaml|opam)
            export PATH="$PATH:$PKGS_PATH/ocaml/opam/bin/"
            eval $(opam env)
            ;;
        ruby|rail|rvm)
            P="$PKGS_PATH/rvm"
            export rvm_path=$P
            source "$P/scripts/rvm"
            ;;
        cabal|haskell|stack)
            PATH="$PKGS_PATH/haskell/cabal/bin:$PKGS_PATH/haskell/ghc/bin:$PKGS_PATH/haskell/stack/bin:$PATH"
            ;;
        otp|erlang|erl|rebar)
            export PATH="$PKGS_PATH/erlang/bin:$PATH"
            export REBAR_CACHE_DIR="$PKGS_PATH/erlang/rebar-cache/"
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
        elm)
            export ELM_HOME="$PKGS_PATH/elm/elm-home/"
            mkdir -p "$ELM_HOME"
            export PATH="$PKGS_PATH/elm/bin/:$PATH"
            ;;
        go)
            export PATH="$PKGS_PATH/go/dist/bin:$PATH:$PKGS_PATH/go/go-workspace/bin"
            export GOCACHE="$PKGS_PATH/go/go-cache/"
            export GOPATH="$PKGS_PATH/go/go-workspace/"
            export CGO_ENABLED=0
            export GO111MODULE=on
            ;;
        go-workspace)
            export GOPATH="$PWD"
            export PATH="$PATH:$GOPATH/bin"
            ;;
        idris2|idris)
            export PATH="$PATH:$PKGS_PATH/idris2/bin/"
            ;;
        chezscheme)
            export PATH="$PATH:$PKGS_PATH/chezscheme/bin"
            ;;
        zz)
            export PATH="$PATH:$PKGS_PATH/zz/bin/"
            ;;
        *)
            echo "No such package"
            return 127
            ;;
    esac
}
