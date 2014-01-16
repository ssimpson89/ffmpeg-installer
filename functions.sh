#!/bin/bash

traps() {
    if [ -L /usr/bin/perl ]
    then
        trap "rm -f /usr/bin/perl ; mv /usr/bin/perl.old /usr/bin/perl ; rm -rf /opt/wt-perl" EXIT
    fi
}

dots() {
    echo -en '\r'
    echo -en "$1 \t ............................................. " 
    
    case "$2" in 
    0) echo -en '\e[0;32m Complete \e[0m \n'
    ;;
    1) echo -en '\e[0;31m Failed \e[0m \n'
    ;;
    *) echo -en '\e[0;33m Running \e[0m'
    ;;
    esac
}

usage() {
    echo "FFMPEG Installer Tool"
    echo "Usage: [-f:--force, -h:--help, --bin-only]"
}

opts() {
    params="$(getopt -o hf -l help,force,bin-only -- "$@")"

    eval set -- "$params"
    unset params

    while true
    do
        case $1 in
            -h|--help)
                usage
                exit 0
                ;;
            -f|--force)
                break
                ;;
            --bin-only)
                export global binonly=true
                break
                ;;
            --)
                shift
                break
                ;;
            *)
                usage
                break
                ;;
        esac
    done
}