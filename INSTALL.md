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

    echo /sys/class/net/e*

In the example below, this system has two Ethernet adapters: enp1s0 and enp2s0.

    [apert@nixos:~]$ echo /sys/class/net/e*
    /sys/class/net/enp1s0 /sys/class/net/enp2s0

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

    sudo vi /etc/nixos/routing.nix
    # set iface_uplink and iface_downlink at the top of the file

Almost everything in Apert is configurable but hold off on making any other
changes until the basic functionality is working.

The default user name is `apert` and the default password is `apert`.


## Test the installation

The following command will check the configuration errors and, if everything is
fine, will run a test installation. The changes are not committed to disk and
if the system is rebooted, it will revert to its previous state.

    sudo nixos-rebuild test

If everything went well, apert should be alive! Let us verify that everything is working:

First, the uplink to the Internet should have a DHCP address. The exact values
don't matter, just that there is a valid an IP address listed after 'inet'.

    ip -o -4 show link enp2s0  # replace enp2s0 with actual uplink name
    3: enp2s0    inet 67.100.23.9/24 brd 255.255.255.255 scope global dynamic [...]

Use ping to test Internet connectivity:

    ping google.com

Now, if we list the downlink, it should list the IP address of the DHCP subnet:

    ip -o -4 show link enp1s0  # replace enp1s0 with actual downlink name
    2: enp1s0    inet 10.100.0.1/24 scope global enp1s0 [...]

In the output, 10.100.0.1 matches the address that was assigned in `routing.nix`.

If a device is connected to the downlink port, it should retrieve a DHCP IP
address, such as 10.100.0.100.

Apert is installed and the basic functionality is working!
