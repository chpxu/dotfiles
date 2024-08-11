{pkgs, ...}: {
  programs.mpv = {
    enable = true;
    package = pkgs.mpv;
    config = {
      profile = "gpu-hq";
      vo = "gpu-next";
      ao = "pipewire,alsa/pipewire,pulse";
      audio-channels = "auto";
      ytdl-format = "bestvideo+bestaudio";
      gpu-context = "wayland";
      # cache-default = 4000000;/
    };
  };
}
