# Apert Installation

This guide provides step-by-step instructions for installing Apert.

## Hardware Requirements

* PC supported by NixOS
* Two physical Ethernet ports (can be USB)

## Install NixOS

Begin by installing NixOS on the system.

The easiest method is to use the NixOS graphical installer. Download the
Graphical ISO image from the [NixOS download
page](https://nixos.org/download.html). Note that the graphical login will
eventually be removed.

Most of the configuration will be replaced later in the guide, so just accept
all the defaults.

Advanced users or users wanting more control can follow the [NixOS installation
guide](https://nixos.org/manual/nixos/stable/index.html#ch-installation).

Once the system is installed and booting, proceed to the next step.


## Determine uplink and downlink

Apert uses an uplink for traffic going to the Internet and a downlink for
traffic going to the home network.

List all of the Ethernet devices on the system:

    cd /sys/class/net && echo e*

In the example below, the system has two Ethernet adapters: enp1s0 and enp2s0.

    [apert@nixos:~]$ cd /sys/class/net && echo e*
    enp1s0 enp2s0

Make a note of which one will be the uplink and which one will be the downlink.
In this guide, enp2s0 will be the uplink and enp1s0 will be the downlink. Be
sure to replace them with the actual values from your system!


## Copy NixOS configuration files

Make a backup of the existing system configuration:

    sudo cp /etc/nixos/configuration.nix{,.bak}

Copy the files from the git repo's "nixos" directory to /etc/nixos on the new
apert system. Note that the hardware-configuration.nix file will be re-used
from your existing installation.

    sudo cp apert.git/nixos/* /etc/nixos

Update the configuration with the uplink and downlink names from the previous
step:

    sudo vi /etc/nixos/network.nix
    # set iface_uplink and iface_downlink at the top of the file

Almost everything in Apert is configurable but hold off on making any other
changes until the basic functionality is working.

The default user name is `apert` and the default password is `apert`.


## Test the installation

The following command will check the configuration errors and, if everything is
fine, will run a test installation. The changes are not committed to disk and
if the system is rebooted, it will revert to its previous state.

    sudo nixos-rebuild test

If everything went well, apert should be alive!

Let us verify that everything is working. First, check the IP addresses of the
uplink and downlink:

    ip -o -4 addr show

    1: lo    inet 127.0.0.1/8 scope host lo [...]
    2: enp1s0    inet 10.100.0.1/24 scope global enp1s0 [...]
    3: enp2s0    inet 67.100.23.9/24 brd 255.255.255.255 scope global dynamic [...]

In this example output above, the uplink enp2s0 has a DHCP address and the
downlink ep1s0 has the address 10.100.0.1 which was assigned in `routing.nix`.

Use ping to test Internet connectivity:

    ping google.com

If a device is connected to the downlink port, it should retrieve a DHCP IP
address, such as 10.100.0.100.

The basic functionality is working!

Complete the Apert install by making the configuration permanent:

    sudo nixos-rebuild switch
