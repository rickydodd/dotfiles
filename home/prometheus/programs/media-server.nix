{pkgs, ...}: {
  home.packages = with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
    sonarr
    radarr
    bazarr
    prowlarr
  ];
}
