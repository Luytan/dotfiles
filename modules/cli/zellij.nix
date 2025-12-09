{ ... }:
{
  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      default_shell = "fish";
      show_startup_tips = false;
      theme = "catppuccin-macchiato";
    };
  };
}