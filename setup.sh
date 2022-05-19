#!/bin/sh
set -e

die() {
	ret=$?
	printf "fatal error: %s\\n" "$@" >&2
	exit $ret
}

script_root="$(dirname -- "$0")"
ansible_root="${script_root}/ansible"

[ -d "${ansible_root}" ] || die "Did not find directory '${ansible_root}'. \
Check that the script is in the correct directory."

### BEGIN prerequisites

# python3.8: required for Ansible
# rustc, cargo: required for building Ansible pip packages or its dependencies
sudo apt install -y python3.8 python3-pip rustc cargo

# upgrade pip
python3.8 -m pip install -U pip

python3.8 -m pip install ansible

### END prerequisites

~/.local/bin/ansible-playbook --inventory "${ansible_root}/hosts" "${ansible_root}/playbook.yaml"
