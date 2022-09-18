# Table of Contents

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->


- [Table of Contents](#table-of-contents)
- [Development Environment Setup Instructions](#development-environment-setup-instructions)
    - [1. Setup virtual machine software](#1-setup-virtual-machine-software)
        - [VMWare](#vmware)
            - [Installing](#installing)
            - [Creating the VM](#creating-the-vm)
        - [VirtualBox](#virtualbox)
            - [Installing](#installing-1)
            - [Creating the VM](#creating-the-vm-1)
        - [virt-manager](#virt-manager)
            - [Installing](#installing-2)
            - [Creating the VM](#creating-the-vm-2)
        - [UTM](#utm)
            - [Installing](#installing-3)
            - [Creating the VM](#creating-the-vm-3)
    - [2. Log in to the virtual machine](#2-log-in-to-the-virtual-machine)
    - [3. Run the setup script](#3-run-the-setup-script)
        - [Background information](#background-information)
        - [Launch the terminal emulator](#launch-the-terminal-emulator)
        - [Run the setup commands](#run-the-setup-commands)
    - [4. Verify that the setup worked](#4-verify-that-the-setup-worked)
        - [Run catkin build](#run-catkin-build)
        - [Run the simulation of Qubo](#run-the-simulation-of-qubo)
- [Issues](#issues)
    - [`Failed to connect socket to '/var/run/libvirt/virtnetworkd-sock-ro': No such file or directory`](#failed-to-connect-socket-to-varrunlibvirtvirtnetworkd-sock-ro-no-such-file-or-directory)
    - [Gazebo simulation black screen on Apple silicon Mac](#gazebo-simulation-black-screen-on-apple-silicon-mac)
    - [NFS mount issues on Fedora](#nfs-mount-issues-on-fedora)
- [Contributing: Helpful resources for contributing to this code/repository](#contributing-helpful-resources-for-contributing-to-this-coderepository)
    - [Creating a base VM image](#creating-a-base-vm-image)
        - [Creating an image for a different processor architecture](#creating-an-image-for-a-different-processor-architecture)
            - [Linux: virt-manager](#linux-virt-manager)
        - [Initial setup](#initial-setup)
            - [OS Installation](#os-installation)
            - [Clone Git repo](#clone-git-repo)
        - [Provisioning the base image](#provisioning-the-base-image)
        - [Cleaning base image](#cleaning-base-image)
            - [Some automatic cleaning](#some-automatic-cleaning)
            - [Clearing first-time GUI popups](#clearing-first-time-gui-popups)
            - [Shutdown the VM](#shutdown-the-vm)
        - [Shrinking the base image](#shrinking-the-base-image)
            - [Eliminating empty sectors](#eliminating-empty-sectors)
            - [Compress](#compress)
        - [Converting to other image formats](#converting-to-other-image-formats)
    - [Suggestions](#suggestions)
        - [Work on feature branches, keep the main 'master' branch working](#work-on-feature-branches-keep-the-main-master-branch-working)
    - [Conventions](#conventions)
        - [Meaning of each of our Ansible roles](#meaning-of-each-of-our-ansible-roles)
    - [README table of contents](#readme-table-of-contents)
    - [Arm GNU Toolchain](#arm-gnu-toolchain)
    - [Ansible](#ansible)
        - [Documentation](#documentation)
        - [Print all Ansible facts](#print-all-ansible-facts)
    - [Saving space](#saving-space)
        - [Listing installed apt packages based on how much space they take](#listing-installed-apt-packages-based-on-how-much-space-they-take)

<!-- markdown-toc end -->

# Development Environment Setup Instructions

Follow these instructions to setup a [virtual machine](https://simple.wikipedia.org/wiki/Virtual_machine) (VM)
development environment for Robotics at Maryland.

NOTE: The configuration automation in this repository is meant for running on a virtual machine.
There is currently no automated *un*install process, and few customization options.
If you wish to set this up on a regular non-VM Ubuntu Linux install, do so at your own risk.

## 1. Setup virtual machine software

If you already have a preferred VM software, just use that.
It will be quicker for you to use what you're used to.

If not, we will just provide instructions for a few options, and suggest which you should choose.

Suggestions:

- If you are using Windows or an Intel Mac:
  - Use VirtualBox.
  - VMWare is also a good choice, but is a bit annoying to install because it requires going through TerpWare to get a student license from UMD.
- If you are using Linux:
  - Use virt-manager. You can also use another frontend (like GNOME Boxes) for the underlying QEMU/Libvirt/KVM technologies, but we have tested virt-manager and can help with it.
  - VirtualBox and VMWare also support Linux. However,
    - We've found some things worked automatically in virt-manager while requiring difficult configuration in VirtualBox.
- If you are using an Arm Apple silicon Mac (M1, M2):
  - Use UTM.
  - VMWare also supports Arm Macs now, but we have not tested it (we do not have access to an Apple silicon Mac).

If you are willing, please contribute instructions for additional VM software.

Jump to the instructions for your VM software:

- [VMWare](#vmware)
- [VirtualBox](#virtualbox)
- [virt-manager](#virt-manager)
- [UTM](#utm)

### VMWare

#### Installing

1. Go to TerpWare: https://terpware.umd.edu
   - VMWare Academic Software is listed under the "Utilities" category.
2. Go through the process of registering for and installing VMWare.
   - VMWare Workstation is for Windows and Linux
   - VMWare Fusion is for Intel-based Macs, but may have a version for Apple ARM CPUs.

#### Creating the VM

**TODO**

Jump to [next step](#2-log-in-to-the-virtual-machine).

### VirtualBox

#### Installing

**TODO**

#### Creating the VM

**TODO**

Jump to [next step](#2-log-in-to-the-virtual-machine).

### virt-manager

#### Installing

**TODO**

#### Creating the VM

**TODO**

Jump to [next step](#2-log-in-to-the-virtual-machine).

### UTM

#### Installing

**TODO**

#### Creating the VM

[Instructions for UTM](https://gitlab.com/robotics-at-maryland/wiki/-/wikis/Setting-up-the-development-environment-on-an-Arm-Apple-silicon-Mac)

Jump to [next step](#2-log-in-to-the-virtual-machine).

## 2. Log in to the virtual machine

The username is "ram".
The default password is "password".
The thinking is that access to your VM is protected by your computer's password and lockscreen.
If you wish to change the password you may, but then if you rerun the "ram setup" it may error out because it assumes the default password.
We'll fix this issue when we encounter it.

## 3. Run the setup script

### Background information

For the sake of clarity, commands you need to run will be in code blocks.
Here is an example code block:

```sh
vm:~/example/directory/path$ echo "hello"
```

Here '`vm:~$ `' is the prompt.
You should see a prompt in your terminal, though it may be different, probably something like `ram@ubuntu:~$`.
You don't type the prompt, it's just there to let you know the shell is ready to receive a command from you.
This document will use prompts to make it clear where you should run the command.
For example, the prompt labeled 'vm' should be run in your **v**irtual **m**achine.

The section of the prompt between the colon and the dollar sign is your working directory (also called "current working directory" or "current directory").
Directories are also known as "folders".
The `~` ("tilde") is an abbreviation for your "home" directory, the place where you can store your files.
You will usually start out in your home directory.

The commands in this document will be short and you may be using them often, so it could be a good idea to type them out.
If you decide to use copy and paste, be take care to not copy the prompt.

So, to run the above command you would type `echo "hello"` into the terminal, then press enter/return to run the command.

### Launch the terminal emulator

Ways to launch the terminal emulator:

- Ctrl+Alt+t
- The Super key (commonly has Windows logo. On Macs the Command key may act as Super) opens the app launcher, then start typing "terminal" and click on the Terminal icon.
- Click on the grid of dots in the bottom left corner (bottom of the app dash/dock on the left), then start typing "terminal" and click on the Terminal icon.

### Run the setup commands

This tends to take around 1-2 minutes to run.
You will be asked for your password (it's "password"), potentially multiple times.
You may not see anything as you type your password, not even filler characters like stars/asterisks.

Partway through it will pause to ask you to add an SSH public key to GitLab.
Your SSH keypair will authenticate you with GitLab, allowing you to contribute to the Robotics @ Maryland code repositories.
It will generate the key for you, you just need to follow the instructions (which will be printed to your terminal) to add it to GitLab.

```sh
vm:~$ sudo apt update && sudo apt upgrade -y
vm:~$ ram setup
```

## 4. Verify that the setup worked

### Run catkin build

```sh
vm:~$ cd ~/qubo
vm:~/qubo$ catkin build; echo "status: $?"
```

If everything went well, Catkin won't have complained, and you should see "status: 0" at the end of the output.
If you see a number other than zero for the status, something has gone wrong.

If something went wrong:

- Check that you typed the command correctly
- Make sure that you are in the `~/qubo` directory.
  - Your prompt should tell you what directory you're in.
  - The command `pwd` will tell you your working directory.
- If you can't figure out what went wrong or how to fix it, that's okay! We don't expect you to know this stuff right away. Ask around or ask a lead for help.

### Run the simulation of Qubo

TODO

# Issues

## `Failed to connect socket to '/var/run/libvirt/virtnetworkd-sock-ro': No such file or directory`
`systemctl start libvirtd`
`systemctl start virtnetworkd`

## Black screen "kernel panic" on VirtualBox

1. Open settings for your virtual machine
2. Go to "System"
3. Go to "Processor" tab
4. Set the number of processors to 2.

For some reason there is something wrong with having 1 processor, but 2 works.

Source: https://askubuntu.com/a/1414397

## VirtualBox I/O Cache error

1. Open settings for your virtual machine
2. Go to "Storage"
3. Click on the "Controller: SATA"
4. Make sure "Use Host I/O Cache" is checked/enabled.

## Gazebo simulation black screen on Apple silicon Mac

We have not tested it yet, but there seems to be a solution in this Reddit thread: https://www.reddit.com/r/ROS/comments/qhk6s3/gazebo_m1_virtual_machine/

"Now he is using UTM as virtual machine with ubuntu server. You need to change a setting of gpu in the menu display-> from default to vitro-ramfb."

## NFS mount issues on Fedora
<https://developer.fedoraproject.org/tools/vagrant/vagrant-nfs.html>
# Contributing: Helpful resources for contributing to this code/repository
## Creating a base VM image

If you have been given a base image already, and are just trying to setup the provided Robotics @ Maryland development environment, this section of the instructions are unnecessary for you.
This section is for members working on improving the development environment automation.

### Creating an image for a different processor architecture

Most members will probably have an x86\_64 computer, but especially with the new Apple silicon Arm Macs and Chromebooks, Arm processors are becoming more common.

qemu-system-aarch64 can emulate an Arm processor, allowing you to make an Arm VM image without using an Arm computer.
QEMU can also emulate x86\_64 if you're on an Arm processor.

Why not just have the members' computers emulate to run the "regular" base image?
Because emulation is slow.
So setting up an emulated base image will probably take longer, but hopefully most of that extra time will not require user-interaction.

#### Linux: virt-manager

- Start the creation of a new VM.
- If the first window in the popup wizard doesn't have an "Architecture options" dropdown:
  - Check your Linux distribution's package manager for a package named something like `qemu-system-aarch64` (or `qemu-system-x86` if you're trying to emulate x86).
    Install it, then start over. If it still doesn't show up try restarting virt-manager, then if necessary restarting your computer.
  - Note: `qemu-system-arm` is different and will not work.
- In the "Architecture options" dropdown select 'aarch64' for the architecture.
- The rest of the installation process should be the same

Notes:

- Ubuntu only seems to provide an Ubuntu Server installation ISO for Arm (they call it 'arm64') for Ubuntu 18.04.
  - So you will need to use the TUI Server installer rather than the Desktop graphical installer.
    The Server installer is not difficult to use but it asks more questions than the Desktop installer.

### Initial setup

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

#### OS Installation

Currently we are using Ubuntu 18.04 LTS, and the configuration automation is targeted to that.
If you want to use a newer version of Ubuntu or a different operating system, the Ansible playbook needs to be updated or extended to support that operating system.
For a newer Ubuntu version, it may just require testing that the Ansible playbook still works, but it also may require modifying the playbook.

You can use the GUI installer or the server ISO with a TUI installer, whichever you prefer.
Do not use a special Ubuntu flavor (in order to do so you would have to change the playbook to not install `ubuntu-desktop`).
The default Ubuntu desktop environment will be installed by the Ansible playbook regardless.

Name the user you create during the installation "ram", and give it the default password of "password". Make sure it has permission to `sudo` to escalate to root privileges.

From here on you may work over the TTY, SSH, or the GUI, whichever you prefer.

If you choose to work with the GUI, read "[Clearing first-time GUI popups](#clearing-first-time-gui-popups)" first as you will encounter it right away.

#### Clone Git repo

Clone this Git repository to the VM, to the directory `~/.dev-env/`.

```sh
vm$ git clone https://gitlab.com/robotics-at-maryland/dev-env.git ~/.dev-env
```

### Provisioning the base image

Some parts of the setup take a long time, but can be done ahead-of-time.
For example, upgrading and installing packages.
Pre-provisioning performs only the operations that can be done ahead-of-time.

Note: Unlike `ram setup`, `ram image provision` does not automatically update to the latest version of the remote Git repository's 'master' branch.
If you have made changes to the remote since cloning, do a `git pull` first.

```sh
vm$ sudo apt update && sudo apt upgrade -y
vm$ ~/.dev-env/bin/ram image provision
vm$ # Or, all at once:
vm$ sudo apt update && sudo apt upgrade -y && ~/.dev-env/bin/ram image provision
```

It can take upwards of 50 minutes (mostly depending on network connection).
Ideally you should only be asked for the password or other input once, so that you can do something else while it's running.
`ram image provision` only asks for input once at the start.
However, if you run the commands all-at-once the `sudo` password cache may time out, so you may have to type your password twice: once for `apt update` and `apt upgrade`, then once for the beginning of `ram image provision`.
In practice this has not happened and it is suggested that you run them all at once so that you can do something else while it's running.

### Cleaning base image

#### Some automatic cleaning

When the image is ready for distributing to others, you should clean it.
This will make the image more like a first boot by removing some files that are touched during the setup process.

```sh
vm$ sudo apt autoremove
vm$ ~/.dev-env/bin/ram image clean
```

Follow any instructions it gives you.

#### Clearing first-time GUI popups

Log in to the GUI, then if you get a popup:

- Don't enable LivePatch.
- Opt-out of telemetry, don't send system information to Canonical.
- If you get a popup asking about upgrading to a newer version of Ubuntu, select the option that amounts to "no, don't ask me again".
  - It doesn't show up right away. If you wait 3 minutes it probably will. Don't wait too long, it's not vital.
- Go through the rest of the popup wizard.

#### Shutdown the VM

Once you are done setting up the base image, shut down the VM.

### Shrinking the base image

#### Eliminating empty sectors

You can eliminate the empty sectors in a qcow2 file with `qemu-img convert`.

```sh
host$ qemu-img convert -f qcow2 -O qcow2 <INPUT-IMAGE> <OUTPUT-IMAGE>
host$ # Replace old version with the smaller sparse image.
host$ mv <OUTPUT-IMAGE> <INPUT-IMAGE>
```

#### Compress

Not all VM software supports compressed images well, so we will just use a compressed transport format that is then decompressed on the user's computer.

Create a Zip file, 7zip file, compressed tarfile, etc.
Zip files can be easily decompressed on MacOS and MS Windows without installing additional software (and most Linux distributions), so they are generally a good format.
You may want to set the compression to the highest level to get the minimum file size; on the command-line utility from Info-ZIP you can use the `-9` option to do this.

Keep the uncompressed copy, at least for now, as you will need it for converting to other image formats.

### Converting to other image formats

Formats:

- `qcow2` -- "QEMU Copy on Write". Used by QEMU.
- `vmdk` -- "Virtual Machine Disk". Used by VMWare, VirtualBox can use.
- `vdi` -- "VirtualBox disk image".

`qemu-img convert -f <INPUT_FORMAT> -O <OUTPUT_FORMAT> <INPUT_FILENAME> <OUTPUT_FILENAME>`

## Suggestions

### Work on feature branches, keep the main 'master' branch working

The automation automatically downloads the latest version of itself from the 'master' branch.
So if you were to push broken code to master, it could break the environment of anyone who runs `ram setup` before a fix is pushed.

When you are making changes to the code, especially non-trivial changes, test it before you push to master.
If the changes are small and you finish them in a single session this can be done all on your computer, then pushing to master once you've tested.
Though it is still suggested to make a feature branch on your PC to make it more difficult to accidentally push broken code to master.

If you're working on a feature for a longer period of time, with other people, then push your feature branch to the remote for the sake of collaboration and backups.

## Conventions
### Meaning of each of our Ansible roles

We have 3 roles:

- base
  - Things to be included in the base image distributed to members.
  - Defaults that can be overriden.
    - Packages to install by default, packages to remove from the base Ubuntu by default.
    - Should be preference-based. Anything that we absolutely require should instead be in core.
  - Run by `ram image provision`.
  - NOT run by `ram setup`.
    - This fact allows users to override the defaults.
- core
  - Things to be included in the base image distributed to members.
  - Cannot be overridden by users.
  - Run by `ram setup`.
  - Run by `ram image provision`.
  - Anything that our code or configuration depends on should be in here unless it has to be in postinstall.
- postinstall
  - Run by `ram setup`.
  - NOT run by `ram image provision`.

Reasoning for including certain things in the base image is to save the user's time.
Full install and configuration can an hour or longer, so do as much as possible ahead of time.

## README table of contents

The table of contents at the top of this README was automatically generated with the Emacs package [markdown-toc](https://github.com/ardumont/markdown-toc).

The following Emacs Lisp configuration was used:

```lisp
(setq markdown-toc-header-toc-title "")
```

## Arm GNU Toolchain

This is the compiler we use for the Tiva.

NOTE: These instructions are for installing the Arm GNU Toolchain ourselves.
Ideally you would use a package manager.
The reason for the current custom installation is that the version in Ubuntu 18.04's package repos is too old for our code.

Links:

- [Main page](https://developer.arm.com/Tools%20and%20Software/GNU%20Toolchain)
- [Download Arm GNU Toolchain](https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads)

The downloads are broken into 3 sections based on what OS you're running the compiler on: Windows, Linux, and macOS. Our VM runs Linux so use the Linux downloads.

Then each is broken into subsections for what CPU architecture you're using.

As of writing we are using "AArch32 bare-metal target (arm-none-eabi)" for the Tiva.

For the Ansible playbook:

1. Download the SHA256 hash file, and then ideally download and verify the cryptographic signature of the hash file.
2. If the files are correct, copy the hash (don't just compute the hash of the downloaded file, use the hash given to you by Arm) and use it in the part of the Ansible playbook that downloads the Arm GNU Toolchain. The `ansible.builtin.get_url` module has a `checksum` parameter that you can use to verify the downloaded file.
3. Specify the values for the variables in the architecture-specific variable files, e.g. `ansible/roles/software/vars/x86_64.yaml`.

## Ansible
### Documentation

- https://docs.ansible.com/

Usually a web search for "ansible <module/command>" or "ansible <task I want to accomplish>" will tend to find the section of the documentation you want.

If you're trying to use a particular module/command (or your task is accomplished by a module/command) I'd recommend using the official documentation (whether you got there manually or from the web search), as it is quite good.
It has plenty of usage examples along with the listing of all possible arguments you can pass to modules.

### Print all Ansible facts

```sh
ansible localhost -m setup
```

## Saving space
### Listing installed apt packages based on how much space they take

https://unix.stackexchange.com/a/107039

```sh
vm$ dpkg-query -Wf '${db:Status-Status} ${Installed-Size}\t${Package}\n' | sed -ne 's/^installed //p'|sort -nr
```

You'll want to pipe this into a pager such as `less`.
