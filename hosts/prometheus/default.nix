# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{pkgs, ...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Host name
  networking.hostName = "simian";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Static IP
  networking.interfaces.eth0.ipv4.addresses = [
    {
      address = "192.168.0.55";
      prefixLength = 24;
    }
  ];

  # Default gateway
  networking.defaultGateway = "192.168.0.1";

  # Nameservers
  networking.nameservers = ["8.8.8.8"];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Nvidia GPU
  # services.xserver.videoDrivers = ["nvidia"];
  # hardware.opengl.enable = true;
  # hardware.nvidia = {
  # package = config.boot.kernelPackages.nvidiaPackages.stable;
  # modesetting.enable = true;
  # };

  services.xserver.enable = true;

  # Enable the XFCE Desktop Environment.
  # services.xserver.displayManager.lightdm.enable = true;
  # services.xserver.desktopManager.xfce.enable = true;

  # Enable the Plasma 6 Desktop Environment
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.simian = {
    isNormalUser = true;
    description = "simian";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [
      # media server
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable nix-command and Flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  # git
  # vim
  # wget
  # curl
  # ];

  # Set the default editor to vim
  environment.variables.EDITOR = "nvim";

  # Some programs need SUID wrappers, can be configured further or are started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.extraCommands = ''
    iptables -A nixos-fw -p tcp --source 192.168.0.0/24 --dport 6000:9999 -j nixos-fw-accept
    iptables -A nixos-fw -p udp --source 192.168.0.0/24 --dport 6000:9999 -j nixos-fw-accept
    iptables -A nixos-fw -p tcp --source 192.168.0.0/24 --dport 22:22 -j nixos-fw-accept
  '';
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  # Enable Docker to virtualise.
  virtualisation.docker.enable = true;

  # Aliases.
  # programs.bash.shellAliases = {
  # vim = "nvim";
  # };

  services = {
    services.transmission = {
      enable = true;

      settings = {
        download-dir = "~/Downloads";
        rpc-port = 40435;
      };
    };

    jellyfin = {
      enable = true;
      dataDir = "/media/data/jellyfin/data";
      cacheDir = "/media/data/jellyfin/cache";
      configDir = "/media/data/jellyfin/config";
      logDir = "/media/data/jellyfin/log";
    };

    sonarr = {
      enable = true;
      dataDir = "/media/data/sonarr";
    };

    radarr = {
      enable = true;
      dataDir = "/media/data/radarr";
    };

    prowlarr.enable = true;
    bazarr.enable = true;
  };
}
