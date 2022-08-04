{ pkgs, ... }:

let
  dns_port = 53;
  prometheus_metrics_port = 4000;
in {
  networking.firewall.allowedTCPPorts = [ dns_port ];
  networking.firewall.allowedUDPPorts = [ dns_port ];

  services.blocky = {
    enable = true;
    settings = {
      port = dns_port;
      httpPort = prometheus_metrics_port;
      # CloudFlare for Families, blocks malware and adult
      upstream.default = [ "1.1.1.3" "1.0.0.3" ];

      blocking = {
        blackLists = {
          # Ref: https://github.com/StevenBlack/hosts

          # default = adware + malware + fakenews + gambling + porn
          default = [ "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn/hosts" ];

          # kids = default + social
          kids = [ "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn-social/hosts" ];
        };
        clientGroupsBlock.default = [ "default" ];
        clientGroupsBlock."10.3.0.0/16" = [ "kids" ];
      };

      prometheus = {
        enable = true;
      };

      customDNS = {
        mapping = {
          "apert.lan" = "10.0.0.9";
          "agnate.lan" = "10.0.0.10";
          "tank.lan" = "10.0.0.11";
          "ibis.lan" = "10.0.0.12";
          "jellyfin.lan" = "10.0.0.12";
        };
      };
    };
#    settings = ''
#             - 46.182.19.48
#             - 80.241.218.68
#             - tcp-tls:fdns1.dismail.de:853
#             - https://dns.digitale-gesellschaft.ch/dns-query
#       '';
  };

  services.prometheus.scrapeConfigs = mkif services.blocky.prometheus.enable [
    {
      job_name = "blocky";
      static_configs = [{
        targets = [ "127.0.0.1:${toString prometheus_metrics_port}" ];
      }];
    }
  ];

}
