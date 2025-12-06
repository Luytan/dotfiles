{ config, pkgs, ... }:

{
  home.username = "luytan";
  home.homeDirectory = "/home/luytan";
  home.stateVersion = "25.11";
  imports = [
    ./modules/cli/fish.nix
    ./modules/cli/git.nix
    ./modules/cli/gpg.nix
    ./modules/cli/zoxide.nix
    ./modules/editors/zed.nix
    ./modules/cli/ghostty.nix
    ./modules/editors/vscode.nix

  ];
  #programs.ssh = {
  #  enable = true;
  #  extraConfig = ''
  #    Host *
  #      AddKeysToAgent yes
  #  '';
  #};

  home.packages = with pkgs; [
    #Packages
    fastfetch
    gcc
    gdb
    rsync
    wl-clipboard
    btop
    htop
    eza
    mission-center
    bat
    nvtopPackages.amd
    tldr
    yazi
    fzf
    ripgrep
    filen-desktop
    neovim
    nixfmt
    nil
    nixd
    rustc
    cargo
  ];
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };
  xdg = {
    enable = true;
  };
  home.sessionVariables = {
    EDITOR = "vim";
    TERMINAL = "konsole";
    NIXOS_OZONE_WL = "1";
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
