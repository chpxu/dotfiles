{pkgs, ...}: {
  programs.mpv = {
    enable = true;
    package = pkgs.mpv;
    config = {
      profile = "gpu-hq";
      vo = "gpu";
      ao = "pulse,alsa";
      audio-channels = "auto";
      ytdl-format = "bestvideo+bestaudio";
      gpu-context = "wayland";
      # cache-default = 4000000;/
    };
  };
}
