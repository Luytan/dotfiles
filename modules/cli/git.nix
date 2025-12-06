{ ... }:

{
  programs.git = {
    enable = true;
    userName = "Luytan";
    userEmail = "luytan@khora.me";
    signing = {
      key = "9DF7DF3488EC912A";
      signByDefault = true;
    };
  };
}
