 # Table of Contents

# Development Environment Setup Instructions

Follow these instructions to setup a [virtual machine](https://simple.wikipedia.org/wiki/Virtual_machine)
development environment for Robotics at Maryland.

NOTE: The configuration automation in this repository is meant for running on a virtual machine.
There is currently no automated *un*install process, and few customization options.
If you wish to set this up on a regular non-VM Ubuntu Linux install, do so at your own risk.

## 1: Install virtual machine software
## 2: Create virtual machine for Robotics at Maryland

- TODO Ideally members should not have to go through the Ubuntu install process

## 3: Log in to the virtual machine

The default password is "password".
The thinking is that access to your VM is protected by your computer's password and lockscreen.

## 4: Run the setup script in the virtual machine

You will be asked for your password at the start.

## 4.*: Upload SSH key to GitLab

- TODO The setup script and/or Ansible playbook will pause running after
  generating an SSH key, asking the user to upload the key to GitLab.
  - TODO When trying to clone code repos, if authentication error again ask user
    to upload the key
  - TODO ? Copy to clipboard? Print to terminal to have user select and copy?

# Creating a base VM image

If you have been given a base image already, this section of the instructions are unnecessary for you.
This section is for members working on improving the development environment automation.

## Initial setup

In the code blocks that tell you what commands to run, the prompt (not part of the command, don't type it) is `<location>$ `.
`<location>` tells you where to run the command.
The commands are written for a Unix-like system.

Options for `<location>` and what they mean:

- `host` -- The operating system installed directly on your computer. Where you installed and are running the VM software.
- `vm` -- The virtual machine operating system.

The `#` character starts a comment (just information, not a command to run) that continues until the end of the line.
You don't need to type lines/commands that start with `#`.

Because this is a more involved process than setting up your personal development environment when someone has provided you the base image, the commands are not written to be copied.
Many of them will be acceptable to copy, but some are written assuming you will be able to make the minor adjustment required if it fails due to differences on your computer than what is assumed in this document.

### OS Installation

Currently we are using Ubuntu 18.04 LTS, and the configuration automation is targeted to that.
If you want to use a newer version of Ubuntu or a different operating system, the Ansible playbook needs to be updated or extended to support that operating system.
For a newer Ubuntu version, it may just require testing that the Ansible playbook still works, but it also may require modifying the playbook.

Name the user you create during the installation "ram", and give it the default password of "password".

### Clone Git repo

Clone this Git repository to the VM, to the directory `~/.dev-env/`.

```sh
vm$ git clone https://gitlab.com/robotics-at-maryland/dev-env.git ~/.dev-env
```

If it is easier, you may copy the files from your machine to the VM.
If you do so, it may be a good idea to use a clean clone.
This is because the `.git/` directory in your clone may contain information specific to your clone, which can be somewhat sensitive, e.g. your name or email address.
Either clone from the GitLab, or do a local clone and make sure your clean clone's "origin" remote points to the GitLab rather than the local directory you cloned from.
It is likely you will want to give your clean clone a different name than "dev-env" to avoid a conflict; in that case you will will need to modify the following commands appropriately.

If you have SSH access to the VM and the `scp` command on your host OS, this will copy the files over.
Replace `<VM-IP-ADDRESS>` with the IP address or hostname of your VM.

```sh
host$ scp -r dev-env ram@<VM-IP-ADDRESS>:.dev-env
host$ # If your current directory is this repo, then try:
host$ scp -r . ram@<VM-IP-ADDRESS>:.dev-env
vm$ rm -rf ~/.dev-env/.git
```

## Pre-provisioning

Some parts of the setup take a long time, but can be done ahead-of-time.
For example, upgrading and installing packages.
Pre-provisioning performs only the operations that can be done ahead-of-time.

Once you've done the initial setup, run the following:

```sh
vm$ ~/.dev-env/ram provision
```

It can take upwards of 15 minutes (mostly depending on network connection).
Ideally you should only be asked for the password or other input once, so that you can do something else while it's running.
As of writing that is the case.

## Cleaning base image

When the image is ready for distributing to others, you should clean it.
This will make the image more like a first boot by removing some files that are touched during the setup process.

```sh
vm$ ram clean-image
```

Follow any instructions it gives you, then shutdown the VM.

## Shrinking the base image

### Eliminating empty sectors

You can eliminate the empty sectors in a qcow2 file with `qemu-img convert`.

```sh
host$ qemu-img convert -f qcow2 -O qcow2 <INPUT-IMAGE> <OUTPUT-IMAGE>
host$ # Replace old version with the smaller sparse image.
host$ mv <OUTPUT-IMAGE> <INPUT-IMAGE>
```

### Compress

Not all VM software supports compressed images well, so we will just use a compressed transport format that is then decompressed on the user's computer.

Create a Zip file, 7zip file, compressed tarfile, etc.
Zip files can be easily decompressed on MacOS and MS Windows without installing additional software (and most Linux distributions), so they are generally a good format.
You may want to set the compression to the highest level to get the minimum file size; on the command-line utility from Info-ZIP you can use the `-9` option to do this.

## Converting to other image formats

Formats:

- `qcow2` -- "QEMU Copy on Write". Used by QEMU.
- `vmdk` -- "Virtual Machine Disk". Used by VMWare, VirtualBox can use.
- `vdi` -- "VirtualBox disk image".

`qemu-img convert -f <INPUT_FORMAT> -O <OUTPUT_FORMAT> <INPUT_FILENAME> <OUTPUT_FILENAME>`
# Issues

## `Failed to connect socket to '/var/run/libvirt/virtnetworkd-sock-ro': No such file or directory`
`systemctl start libvirtd`
`systemctl start virtnetworkd`

## NFS mount issues on Fedora
<https://developer.fedoraproject.org/tools/vagrant/vagrant-nfs.html>
