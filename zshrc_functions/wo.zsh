wo()
{
    cursor="$PWD"
    until [ "$cursor" = "/" ]
    do
        f=$(print "${cursor}/".(^deployment_virtualenv)/bin/activate) 2> /dev/null
        if [ -f "$f"  ]
        then
            source "$f"
            return 0
        fi
        cursor=$(dirname "$cursor")
    done

    echo "No virtualenv found"
    return 127
}
