tmpvenv() {
    cd $(mktemp -d) && venv "$@" && wo
    cd -
}
