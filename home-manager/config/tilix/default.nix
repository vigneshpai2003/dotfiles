{ config, ... }:
{
  home.file.".config/tilix/schemes" = {
    source = ./schemes;
  };
}
