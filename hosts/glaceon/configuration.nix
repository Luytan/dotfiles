{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./disko-config.nix
      ../../modules/common/fonts.nix
      ../../modules/services/asusctl.nix
      ../../modules/services/tuned.nix
      ../../modules/services/cpu-boost.nix
      ../../modules/common/bluetooth.nix
      ../../modules/containers/podman.nix
    ];

  # Bootloader & Kernel
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.systemd.enable = true;
  services.system76-scheduler.enable = true;
    # AMD Microcode
  hardware.cpu.amd.updateMicrocode = true;
  # Plymouth
  boot.plymouth = {
      enable = true;
      theme = "bgrt";
  };
  boot.consoleLogLevel = 3;
  hardware.enableAllFirmware = true;
  boot.initrd.verbose = false;
  boot.kernelParams = [
      "video=2560x1600@120"
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
  ];
  boot.loader.timeout = 0;

  boot.kernel.sysctl = {
    "vm.swappiness" = 180;
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;
    "vm.page-cluster" = 0;
  };

  # Networking & Time
  networking.hostName = "glaceon";
  networking.networkmanager = { 
    enable = true;
    wifi.macAddress = "random";
  };
  time.timeZone = "Europe/Paris";

  # i18n & Console
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
    keyMap = "us";
    earlySetup = true;
  };
  systemd.services.systemd-vconsole-setup.unitConfig.After = "local-fs.target";

  # Hardware & Graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.amdgpu.initrd.enable = true;
  services.tailscale.enable = true;
  # Nix Settings
  nix.gc = {
    automatic = true;
    dates = "weekly";
  };
  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # Desktop Environment
  ## KDE Plasma
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;
  ## Cosmic Desktop
  #services.desktopManager.cosmic.enable = true;
  #services.gnome.gnome-keyring.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Virtualization
  virtualisation.libvirtd = {
      enable = true;
      qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
  };
  virtualisation.vmware.host.enable = true;
  programs.virt-manager.enable = true;

  # Services
  services.printing.enable = true;
  services.flatpak.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };
  services.libinput.enable = true;

  # Users
  users.users.luytan = {
    isNormalUser = true;
    extraGroups = [ "wheel" "dialout" "libvirtd" ]; 
    packages = with pkgs; [
      vmware-workstation 
    ];
  };

  # Programs
  programs.nix-ld.enable = true;
  environment.systemPackages = with pkgs; [
    vim
    virt-what
    wget
    tpm2-tss
    linux-firmware
  ];
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  nix.settings.allowed-users = [ "@wheel" ];

  # Zram
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 300;
  };

  system.stateVersion = "25.11"; 
}
