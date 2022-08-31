# Architecture / Ideas

- VM software
  - Vagrant makes things really easy, but I couldn't get it working.
    For now I will focus on just the automation once you have Ubuntu installed, and creating base images for popular VM software so people don't have to go through the Ubuntu install process.
- Ansible
  - [ ] Don't ask to upload SSH keys to GitLab every time. Save whether we've already ask to a file, and check that file.
- ? Further custom commands
  - [x] Update / re-run playbook
  - [ ] Command to run 'git fetch' on all repositories so ready to go offline.
- Desktop environment
  - Do we need one?
    - Maybe can get by just with X forwarding or similar.
      There aren't that many GUI programs we run, so avoiding having to learn a new desktop environment would be nice.
  - If we do use one, probably just the default Ubuntu.
    It's what people are most likely (of the options, it's Linux) to have been exposed to.
    It's easy for new people to use.
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
