# The inability to use ${HOME} is annoying
env GOCACHE=/home/antoine/.pkgs/go/cache
env GOPATH=/home/antoine/.pkgs/go/workspace

read-write ${HOME}/.pkgs/go/cache
