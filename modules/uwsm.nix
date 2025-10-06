{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    uwsm
  ];

  # UWSM service configuration
  systemd.user.services.uwsm = {
    Unit = {
      Description = "Universal Wayland Session Manager";
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      Type = "simple";
      ExecStart = "${pkgs.uwsm}/bin/uwsm start";
      Restart = "on-failure";
    };
  };
}
