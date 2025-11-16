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
  ];

  programs.kitty = {
    enable = true;
    font.size = 15;
    font.name = "FiraCode Nerd Font";
    themeFile = "Argonaut";
    settings = {
      disable_ligatures = "never";
      copy_on_select = "yes";
      background_opacity = 0.87;
    };
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.


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

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/larsski/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
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

  programs.bash = {
    enable = true;
    shellAliases = {
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      la = "ls -a";
      g = "git status";
      gcan = "git commit -a --amend --no-edit";
      vim = "nvim";
      clc = "fc -ln -1 | sed 's/^\s*//' | sed 's/\s*$//' | tr -d '\n' | xsel --clipboard";
      lt = "exa -aT";
    };
  };
}
