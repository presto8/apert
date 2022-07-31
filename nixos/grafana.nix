{ config, ... }:

{
  networking.firewall.allowedTCPPorts = [
    config.services.grafana.port
  ];

  services.grafana = {
    enable = true;
    domain = "localhost";
    port = 2342;
    addr = "0.0.0.0";  # bind to all interfaces
    provision = {
      enable = true;
      datasources = [
        {
          name = "Prometheus";
          type = "prometheus";
          access = "proxy";
          url = "http://localhost:${toString config.services.prometheus.port}";
          isDefault = true;
        }
      ];
    };
  };

}
