#!/bin/sh

# Ansible is easy :-)

run() {
    cmd='/usr/bin/ansible-playbook -i inventory/local -c local'
    echo "$cmd" "$@"
    echo
    $cmd "$@"
}

run master.yml "$@"
