{
  pkgs,
  nixvim,
  ...
}: {
  home.packages = with pkgs;
  with nixvim; [
    # archives
    git
    zip
    unzip
    p7zip

    # utils
    ripgrep # Performance improved grep-like.

    # misc
    xdg-utils

    # text
    vim

    nixvim.packages."aarch64-linux".default
  ];

  programs = {
    git = {
      enable = true;

      userName = "Ricky Dodd";
      userEmail = "63101193+rickydodd@users.noreply.github.com";
    };

    eza.enable = true; # Modern `ls`.
    ssh.enable = true;

    bash = {
      enable = true;
      shellAliases = {
        vim = "nvim";
      };
    };
  };
}
