{
  imports = [
    ./programs
  ];

  home = {
    username = "simian";
    homeDirectory = "/home/simian";

    stateVersion = "23.11";
  };

  # Enable home manager.
  programs.home-manager.enable = true;
}
