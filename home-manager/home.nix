{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "larsski";
  home.homeDirectory = "/home/larsski";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    nerd-fonts.fira-code
    curl
    git
    neovim
    ripgrep
    xclip
    xsel
    eza
  ];
  home.shell.enableZshIntegration = true;

  xdg.configFile."nvim".source = ./nvim;

  programs.kitty = {
    enable = true;
    font.size = 15;
    font.name = "FiraCode Nerd Font";
    themeFile = "Argonaut";
    settings = {
      disable_ligatures = "never";
      copy_on_select = "yes";
      background_opacity = 0.87;
      shell = "${pkgs.zsh}/bin/zsh";
    };
  };

  services.flameshot.enable = true;
  services.flameshot.settings = {
    General = {
      showStartupLaunchMessage = false;
      savePath="/home/larsski/Pictures";
    };
  };

  home.stateVersion = "25.05"; 
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    settings = {
      user.name = "Lars Skifjeld";
      user.email = "larssski@proton.me";
      init.defaultBranch = "main";
      core.editor = "nvim";
      pull.rebase = true;
      rerere.enabled = true;
    };
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      la = "ls -a";
      cl = "clear";
      g = "git status";
      gcan = "git commit -a --amend --no-edit";
      vim = "nvim";
      clc = "fc -ln -1 | sed 's/^\s*//' | sed 's/\s*$//' | tr -d '\n' | xsel --clipboard";
      lt = "eza -aT";
    };
  };
  programs.autojump.enableZshIntegration = true;
  programs.atuin.enableZshIntegration = true;
  programs.dircolors.enableZshIntegration = true;
  programs.fzf.enableZshIntegration = true;
}
