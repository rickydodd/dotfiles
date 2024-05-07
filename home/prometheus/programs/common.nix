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
    qbittorrent

    # utils
    ripgrep # Performance improved grep-like.
    yq-go # YAML processor.

    # misc
    xdg-utils

    # text
    vim

    nixvim.packages."x86_64-linux".default
  ];

  programs = {
    git = {
      enable = true;

      userName = "Ricky Dodd";
      userEmail = "63101193+rickydodd@users.noreply.github.com";
    };

    eza.enable = true; # Modern `ls`.
    jq.enable = true; # JSON processor.
    ssh.enable = true;

    bash = {
      enable = true;
      shellAliases = {
        vim = "nvim";
      };
    };
  };
}
