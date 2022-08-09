# Instructions

Follow these instructions to setup a [virtual machine](https://simple.wikipedia.org/wiki/Virtual_machine)
development environment for Robotics at Maryland.

## 1: Install virtual machine software
## 2: Create virtual machine for Robotics at Maryland

- TODO Ideally members should not have to go through the Ubuntu install process

## 3: Run setup script in virtual machine
## 3.*: Upload SSH key to GitLab

- TODO The setup script and/or Ansible playbook will pause running after
  generating an SSH key, asking the user to upload the key to GitLab.
  - TODO When trying to clone code repos, if authentication error again ask user
    to upload the key
  - TODO ? Copy to clipboard? Print to terminal to have user select and copy?

# Issues

## `Failed to connect socket to '/var/run/libvirt/virtnetworkd-sock-ro': No such file or directory`
`systemctl start libvirtd`
`systemctl start virtnetworkd`

## NFS mount issues on Fedora
<https://developer.fedoraproject.org/tools/vagrant/vagrant-nfs.html>
