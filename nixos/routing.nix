{ pkgs, ... }:

# Ref: https://francis.begyn.be/blog/nixos-home-router

let
  iface_uplink = "enp2s0";  # FIXME
  iface_downlink = "enp1s0";  # FIXME
in {
  boot.kernel.sysctl = {
    "net.ipv4.conf.all.forwarding" = true;

    # TODO: IPv6
  };

  networking.useDHCP = false;
  networking.interfaces.uplink.name = iface_uplink;
  networking.interfaces.uplink.useDHCP = true;

  networking.nat.enable = true;
  networking.nat.externalInterface = iface_uplink;
  networking.nat.internalInterfaces = [ iface_downlink];

  networking.interfaces.downlink.name = iface_downlink;
  networking.interfaces.downlink.ipv4.address = [{
    address = "10.100.0.1";
    prefixLength = 24;
  }];

  services.dhcpd4 = {
    enable = true;
    interfaces = [ iface_downlink];
    extraConfig = ''
      option domain-name-servers 10.100.0.1;
      option subnet-mask 255.255.255.0;

      subnet 10.100.0.0 netmask 255.255.255.0 {
        interface enp1s0;
        option routers 10.100.0.1;
        # by default, the router will also be the DNS; override it here if desired
        #  option domain-name-servers 10.100.0.1;
        #  option domain-name "mydomain.org";
        option broadcast-address 10.100.0.255;
        range 10.100.0.100 10.100.0.200;
      }
  };

 #  services.dhcpd4.machines = [
 #    {
 #      ethernetAddress = "14:22:db:82:f7:6d";
 #      host = "eero-gw";
 #      ipAddress = "10.100.0.10";
 #    }
 #  ];

}

# TODO - vlans

#   networking.vlans = {
#     wan = {
#       id = 10;
#       interface = iface_downlink;
#     };
#     lan = {
#       id = 20;
#       interface = iface_downlink;
#     };
#   };
