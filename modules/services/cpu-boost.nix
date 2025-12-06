{ pkgs, ... }:
{
  # I hate cpu boost
  systemd.services.force-disable-boost = {
    description = "Force disable CPU Boost";
    after = [ "tuned.service" "multi-user.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
    script = ''
      if [ -f /sys/devices/system/cpu/cpufreq/boost ]; then
        echo 0 > /sys/devices/system/cpu/cpufreq/boost
      fi
      
      if [ -f /sys/devices/system/cpu/intel_pstate/no_turbo ]; then
        echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo
      fi
    '';
  };
}