{ config, ... }:
{
  home.file."${config.xdg.configHome}/tilix/schemes".source = ./schemes;
}
