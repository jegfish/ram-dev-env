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

# For now the password will just be hard-coded as 'password'.
# We are assuming that the password on an account in a virtual machine doesn't matter much.
# If setup SSH should disable password authentication.
# If setup any other services that should be accessible from outside the VM locally, secure it somehow.
# If setup services that should be accessible from outside the VM from the network, definitely secure it somehow.
# Eventually we may include changing the password as a post-installation step.
~/.local/bin/ansible-playbook --inventory "${ansible_root}/hosts" "${ansible_root}/playbook.yaml" --extra-vars='ansible_become_pass=password'
