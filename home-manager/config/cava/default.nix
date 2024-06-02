{ config, ... }:
{
  home.file."${config.xdg.configHome}/cava/config".source = ./config;
}
