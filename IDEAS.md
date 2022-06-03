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
- ? Further custom commands
  - [ ] Update / re-run playbook
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
