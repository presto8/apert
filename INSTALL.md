# Apert Installation

This guide provides step-by-step instructions for installing Apert.

## Hardware Requirements

* PC supported by NixOS
* Two physical Ethernet ports (can be USB)

## Install NixOS

Begin by installing NixOS on the system.

The easiest method is to use the NixOS console installer. Download the Minimal
ISO image from the [NixOS download page](https://nixos.org/download.html). The
Graphical ISO image can also be used, however the very next step in the
installation will remove all of the graphical components.

Most of the configuration will be replaced later in the guide, so just accept
all the defaults.

Advanced users or users wanting more control can follow the [NixOS installation
guide](https://nixos.org/manual/nixos/stable/index.html#ch-installation).

Once the system is installed and booting, proceed to the next step.


## Determine uplink and downlink

Apert uses an uplink for traffic going to the Internet and a downlink for
traffic going to the home network.

List all of the Ethernet devices on the system:

    ls -1d /sys/class/net/e*

In the example below, this system has two Ethernet adapters: enp1s0 and enp2s0.

    [apert@nixos:~]$ ls -1d /sys/class/net/e*
    /sys/class/net/enp1s0
    /sys/class/net/enp2s0

Make a note of which one will be the uplink and which one will be the downlink.


## Copy NixOS configuration files

Make a backup of the existing system configuration:

    sudo cp /etc/nixos/configuration.nix{,.bak}

Copy the files from the git repo's "nixos" directory to /etc/nixos on the new
apert system. Note that the hardware-configuration.nix file will be re-used
from your existing installation.

    sudo cp apert.git/nixos/* /etc/nixos

Update the configuration with the uplink and downlink names from the previous
step:

    sudo vi /etc/nixos/routing.nix
    # set iface_uplink and iface_downlink at the top of the fil

Almost everything in Apert is configurable but hold off on making any other
changes until the basic functionality is working.

The default user name is `apert` and the default password is `apert`.


## Test the installation

    sudo nixos-rebuild test

If everything went well, the system will still work.
