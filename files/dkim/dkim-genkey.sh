#!/bin/sh

DOMAIN="$1"
SELECTOR="$2"

usage() {
    /usr/bin/cat << 'EOF'
Usage: dkim_genkey.sh DOMAIN SELECTOR

Examples:
    Create a key pair
    dkim_genkey.sh discourse.jamielinux.com discourse-20150601

EOF
}

if [ $# -ne 2 ]; then
    usage
    exit 1
fi

cmd="opendkim-genkey -a -t -b 2048 -d $DOMAIN -s $SELECTOR"
echo "$cmd"
$cmd

if [ -e "${SELECTOR}.private" ]; then
    echo
    echo "Private key:"
    /usr/bin/cat "${SELECTOR}.private"
fi

if [ -e "${SELECTOR}.txt" ]; then
    echo
    echo "Public key:"
    /usr/bin/cat "${SELECTOR}.txt"
fi
