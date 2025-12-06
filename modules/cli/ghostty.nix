{ ... }:
{
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    themes = {
      catppuccin-mocha = {
        background = "24273a";
        cursor-color = "f4dbd6";
        cursor-text = "181926";
        foreground = "cad3f5";
        palette = [
          "0=#494d64"
          "1=#ed8796"
          "2=#a6da95"
          "3=#eed49f"
          "4=#8aadf4"
          "5=#f5bde6"
          "6=#8bd5ca"
          "7=#a5adcb"
          "8=#5b6078"
          "9=#ed8796"
          "10=#a6da95"
          "11=#eed49f"
          "12=#8aadf4"
          "13=#f5bde6"
          "14=#8bd5ca"
          "15=#b8c0e0"
        ];
        selection-background = "3a3e53";
        selection-foreground = "cad3f5";
        split-divider-color = "363a4f";
      };
    };
    settings = {
      command = "fish";
    };
  };
}
