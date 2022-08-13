# Architecture / Ideas

- Initial setup script/wizard
  - May be as simple as running the Ansible playbook, but there is a possibility
    we will want to do some things in the setup wizard rather than the Ansible
    playbook, e.g. interactivity/prompts.
  - [ ] Should be able to change mind on answers to prompts
    - At least should support quitting and restarting the setup process
  - [X] Install Ansible
- Ansible
  - An Ansible playbook will describe the desired state of the system
  - Will be installed on the image, and run against localhost.
  - NOTE: `ansible-pull` may be very convenient if we don't have a VM
    image to start out with. Could be part of a simple script or set
    of commands we have people run to get started.
  - [ ] Don't ask to upload SSH keys to GitLab every time. Save whether we've already ask to a file, and check that file.
- ? Further custom commands
  - [x] Update / re-run playbook
  - [ ] Command to run 'git fetch' on all repositories so ready to go offline.
- [ ] ISO / virtual machine image
  - ? Automatically generate
    - Would be nice to at least not require people to go through the Linux
      install process, though it's easy on Ubuntu.
    - possibly good tool for this: https://www.packer.io/

# Environment

- Operating System: Ubuntu 18.04 Bionic Beaver

## Electrical?

## Mechanical?

## Software

- ROS Melodic

## Embedded

- GCC ARM embedded compiler toolchain
- lm4flash (https://github.com/utzig/lm4tools)
  - Ubuntu: lm4flash

# Improvements

## Speed up

Anything that can be done ahead of time, do so.
Build things like package installs into the source Vagrant box.
Then only for things that have to be unique do them on the user's machine, like generate an SSH key.

Maybe could be done by: `config.vm.provision "preload-box"`

Add an extra provision option, then `vagrant provision --provision-with preload-box`.
Then `vagrant package` or whatever to make a custom box.
Split the Ansible playbook into portions that can be done ahead of time and those that must be done on individual users' machines.
If doesn't make sense to fully split up, use Ansible tags so we can prevent the just-in-time stuff from running.

## Investigate networking options.

Make sure the VM networking is secure.
Don't expose open ports on VM to the local network.
They should only be exposed locally on the host OS.

# Maybe

## Only regenerate SSH keys if necessary.
Use SSH key that person already has if possible.

Note: Only an issue if destroying and recreating the development environment often.
