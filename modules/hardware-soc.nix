{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.mobile.hardware;
in
{
  options.mobile.hardware = {
    soc = mkOption {
      # This is used to enable a specific SOC on a device, while giving it a name.
      type = types.string;
      description = ''
        Give the SOC name for the device.
      '';
    };
  };

  config = {
    assertions = [
      { assertion = cfg.socs ? ${cfg.soc}; message = "Cannot enable SOC ${cfg.soc}; it is unknown.";}
    ];
    mobile.hardware.socs."${cfg.soc}".enable = true;
  };
}
