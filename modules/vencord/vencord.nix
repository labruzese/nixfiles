{ config, lib, ... }:

{
  programs.vesktop.vencord.settings = {
    themeLinks = [ config.theme.vencord ];
    autoUpdate = true;
    autoUpdateNotification = true;
    useQuickCss = true;
  };
}
