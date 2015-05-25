#!/bin/sh

# Ansible is easy :-)
# Go pro by reading <docs/README.remote.rst>.

run() {
    cmd='/usr/bin/ansible-playbook -i inventory/local -c local'
    echo "$cmd" "$@"
    echo
    $cmd "$@"
}

run master.yml "$@"
