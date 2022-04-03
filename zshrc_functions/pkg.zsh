#!/usr/bin/env zsh

pkg() {
    case "x$1" in
        x|x-h|x--help)
          echo 'usage: pkg install <name>'
          echo '       pkg enable  <name>'
          ;;
        *)
          local subcommand="$1"
          shift
          "pkg-${subcommand}" "$@"
          ;;
    esac
}
