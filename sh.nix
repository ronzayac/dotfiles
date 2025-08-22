{ pkgs, ... }:

let

  # Put all shell aliases in this common variable declaration so we only have to manage it here
  myAliases = {
    ls = "eza --icons -l -T -L=1";
    cat = "bat";
    htop = "btm";
    fd = "fd -Lu";
    w3m = "w3m -no-cookies -v";
    neofetch = "disfetch";
    fetch = "disfetch";
    gitfetch = "onefetch";
    "," = "comma";
  };
in
  {
    programs.bash = {
      enable = true;
      enableCompletion = true;
      shellAliases = myAliases;
    };

    programs.zsh = {
      enable = true;
      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      shellAliases = myAliases;
      #initExtra = ''
      #  PROMPT="%U%F{magenta}%n%f%u@%U%F{blue}%m%f%u:%F{yellow}%~%f %F{green}%f "
      #  RPROMPT="%F{red}▂%f%F{yellow}▄%f%F{green}▆%f%F{cyan}█%f%F{blue}▆%f%F{magenta}▄%f%F{white}▂%f"
      #  [ $TERM = "dumb" ] && unsetopt zle && PS1='$ '
      #  bindkey '^P' history-beginning-search-backward
      #  bindkey '^N' history-beginning-search-forward
      #'';
    };

    home.packages = with pkgs; [
      disfetch lolcat cowsay onefetch
      gnugrep gnused
      bat eza bottom fd bc
      direnv nix-direnv
    ];

    programs.direnv.enable = true;
    programs.direnv.enableZshIntegration = true;
    programs.direnv.nix-direnv.enable = true;
}
