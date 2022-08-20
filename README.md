<img src="assets/logo-integrated.png" alt="Aperture logo" />

Apert is an open-source router project based on NixOS.

The name apert is inspired by the aperture of a camera that opens and closes to
control the amount of light that enters the camera. Similarly, apert opens and
closes to control the amount of data that enters the home network.

Apert is an alternative to projects like pfSense, OpenWRT, or OPNsense. Apert
is intended for advanced users who are comfortable editing configuration files
and using command line tools.

# Tech Stack

* OS: NixOS
* Routing: iproute2
* DHCP: dhcpd4
* Firewall, NAT: nftables
* DNS, Ad Blocking: Blocky (with logging to Prometheus)
* Monitoring: Prometheus & Grafana
* Network uptime, latency, and packet loss: SmokePing
* QoS and Traffic Shaping: tc/iproute2 (OpenWrt?)
* Intrusion Detection (IDS): Snort + pulledpork
* VPN: Nebula, ZeroTier, OpenVPN, or WireGuard
* Reverse proxy for home server/dashboard: nginx

# Motivation

<img src="assets/bilbo.jpg" alt="Why shouldn't I have my own router?" align="right" style="width: 200px;" />

I saw this great presentation [Michael Stapelberg: Why I wrote my own
rsync](https://www.youtube.com/watch?v=wpwObdgemoE) and it included a section
on his project, router7.

It occurred to me that rather than trying to modify my Ubiquiti EdgeRouter-X to
do everything I want, it might be easier to just write everything myself.

I looked into available solutions like pfSense and OPNsense, but wanted a
solution that defines the home router declaritively.

And it would be a lot of fun and I would learn a lot. And thus, apert was born.

# Installing

See the [installation guide](INSTALL.md) for instructions on how to set up your
own Apert.

# Ideas

Screen time management: Monitoring then slowly reduce service (latency, bandwidth) until hard cutoff.

# Credits

* Camera aperture icon: Diaphgram Apertures SVG Vector from svgrepo.com (CC0 License)
* Bilbo "Why shouldn't I" meme: imgflip.com
* Apert logo font: Alcubierre from dafontfree.io
* Inspiration to write my own router: Michael Stapelberg

# Similar Projects

* [Creating a NixOS live USB for a full featured APU router](https://dataswamp.org/~solene/2022-08-03-nixos-with-live-usb-router.html)
