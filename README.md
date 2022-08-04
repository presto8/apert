<img src="assets/logo-integrated.png" alt="Aperture logo" />

Apert is an open-source router project based on NixOS.

The name apert is inspired by the aperture of a camera that opens and closes to
control the amount of light that enters the camera. Similarly, apert opens and
closes to control the amount of data that enters the home network. The name is
also inspired by the book [Anathem](https://en.wikipedia.org/wiki/Anathem), in
which a giant door opens periodically during a ceremony called apert to control
the spread of information.

Apert is an alternative to projects like pfSense, OpenWRT, or OPNsense. Apert
is intended for advanced users who are comfortable editing configuration files
and using command line tools.

# Tech Stack

* OS: NixOS
* Routing: iproute2
* DHCP: dhcpd4
* Firewall, NAT: iptables (maybe: nftables)
* DNS, Ad Blocking: Blocky (maybe: AdGuard Home)
  - Logging to Prometheus
* Monitoring: Prometheus & Grafana
* QoS and Traffic Shaping: tc/iproute2
* Intrusion Detection (IDS): Snort
* VPN: Nebula, ZeroTier, OpenVPN, or WireGuard
* Reverse proxy for services: nginx

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

* Camera aperture logo: Diaphgram Apertures SVG Vector from svgrepo.com
* Bilbo "Why shouldn't I" meme: imgflip.com
* Apert logo font: Alcubierre from dafontfree.io
* Inspiration to write my own router: Michael Stapelberg

# Future Research and Reading

- nftables: https://scvalex.net/posts/54/
