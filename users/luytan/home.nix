{ config, pkgs, ... }:

{
  home.username = "luytan";
  home.homeDirectory = "/home/luytan";
  home.stateVersion = "25.11";
  ## FISH
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      zoxide init fish | source
    '';
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/Documents/NixOS/dotfiles#glaceon";
      upd = "nix flake update --flake ~/Documents/NixOS/dotfiles";
      clean = "nix-collect-garbage -d";
    };
  };
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-qt;
  };
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Luytan";
        email = "luytan@khora.me";
      };
    };
    signing = {
      key = "9DF7DF3488EC912A";
      signByDefault = true;
    };
  };
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
        AddKeysToAgent yes
    '';
  };

  home.packages = with pkgs; [
    #Packages
    fastfetch
    vscode
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
    ghostty
    filen-desktop
    neovim
    nixfmt
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
