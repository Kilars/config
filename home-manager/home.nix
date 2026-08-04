{ config, pkgs, ... }:

{
  imports = [ ./claude.nix ];

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
    vscodium
    ripgrep
    fd
    xclip
    xsel
    eza
    bun

    # Neovim LSP servers + formatters (replaces mason; nvim finds these on PATH)
    lua-language-server
    rust-analyzer
    typescript-language-server
    vscode-langservers-extracted # html / cssls / jsonls
    clang-tools # clangd + clang-format
    stylua
    prettier
    shfmt
    tree-sitter # treesitter parser compilation (:TSInstall)
  ];
  home.shell.enableZshIntegration = true;

  xdg.configFile."nvim".source = ./nvim;

  # VSCodium ships its icon only at 1024x1024, a size not declared in any
  # hicolor index.theme, so GNOME's themed lookup fails and shows a generic
  # gear. Override the desktop entry with an absolute icon path (bypasses theme
  # lookup); regenerated with the correct store path on every rebuild.
  xdg.desktopEntries.codium = {
    name = "VSCodium";
    genericName = "Text Editor";
    comment = "Code Editing. Redefined.";
    exec = "codium %F";
    icon = "${pkgs.vscodium}/share/pixmaps/vscodium.png";
    startupNotify = true;
    categories = [ "Utility" "TextEditor" "Development" "IDE" ];
    type = "Application";
    settings = {
      Keywords = "vscode";
      StartupWMClass = "vscodium";
    };
    actions.new-empty-window = {
      name = "New Empty Window";
      exec = "codium --new-window %F";
      icon = "${pkgs.vscodium}/share/pixmaps/vscodium.png";
    };
  };

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

  home.sessionPath = [ "$HOME/.local/bin" ];

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
    initContent = ''
      PROMPT='%F{cyan}%1~%f %# '
    '';
    shellAliases = {
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      la = "ls -a";
      cl = "clear";
      g = "git status";
      glg = "git log --short";
      gcan = "git commit -a --amend --no-edit";
      vim = "nvim";
      codium = "codium --no-sandbox";
      clc = "fc -ln -1 | sed 's/^\s*//' | sed 's/\s*$//' | tr -d '\n' | xsel --clipboard";
      lt = "eza -aT";
    };
  };
  programs.autojump = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.dircolors = {
    enable = true;
    enableZshIntegration = true;
  };
}
