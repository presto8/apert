{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./prometheus.nix
    ./grafana.nix
    ./blocky.nix
    ./routing.nix
    # ./adguardhome.nix
    # ./firewall.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "apert";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.utf8";

  security.sudo.wheelNeedsPassword = false;

  users.mutableUsers = false;
  users.users.apert = {
    isNormalUser = true;
    # to generate a new password, use: mkpasswd -m sha-512
    hashedPassword = "$6$e37lm8S1PMNCJThO$jGfAEKfyNn3bClrM9xoo.orDZajjeHbF9JZ/2aQArDBBPc6epqKytFvVkxNFkhJ0x4epwHrGJjd5ww8sYfpu2.";  # "apert"
    description = "apert";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
  ];

  services.openssh.enable = true;

  system.stateVersion = "22.05";  # Don't change this
}
