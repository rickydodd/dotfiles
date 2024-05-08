{
  imports = [
    ./programs
  ];

  home = {
    username = "atlas";
    homeDirectory = "/home/atlas";

    stateVersion = "23.11";
  };

  # Enable home manager.
  programs.home-manager.enable = true;
}
