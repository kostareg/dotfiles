{
  programs.eza = {
    enable = true;
  };

  programs.bash.shellAliases = {
    ls = "eza --long --icons --header --git --links --grid";
  };
}
