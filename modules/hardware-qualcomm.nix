{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.mobile.hardware.socs;
in
{
  options.mobile = {
    hardware.socs.qualcomm-apq8064-1aa.enable = mkOption {
      type = types.bool;
      default = false;
      description = "enable when SOC is APQ8064–1AA";
    };
    hardware.socs.qualcomm-msm8953.enable = mkOption {
      type = types.bool;
      default = false;
      description = "enable when SOC is msm8953";
    };
    hardware.socs.qualcomm-msm8939.enable = mkOption {
      type = types.bool;
      default = false;
      description = "enable when SOC is msm8939";
    };
  };

  config = mkMerge [
    {
      mobile = mkIf cfg.qualcomm-msm8939.enable {
        system.platform = "aarch64-linux";
        quirks.qualcomm.msm-fb-handle.enable = true;
      };
    }
    {
      mobile = mkIf cfg.qualcomm-msm8953.enable {
        system.platform = "aarch64-linux";
        quirks.qualcomm.msm-fb-handle.enable = true;
      };
    }
    {
      mobile = mkIf cfg.qualcomm-apq8064-1aa.enable {
        system.platform = "armv7a-linux";
        quirks.qualcomm.msm-fb-refresher.enable = true;
      };
    }
  ];
}
