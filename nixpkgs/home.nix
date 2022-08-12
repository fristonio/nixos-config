{ config, lib, pkgs, ... }:

let unstable = import <nixos-unstable> {};
zoom = pkgs.zoom-us.overrideAttrs (old: {
  postFixup = old.postFixup + ''
    wrapProgram $out/bin/zoom-us --unset XDG_SESSION_TYPE
  '';
});

in {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.gpg.enable = true;

  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "fristonio";
  home.homeDirectory = "/home/fristonio";

  home.file = {
    ".vimrc".source = ./vimrc;
    ".bashrc".source = ./bashrc;
    ".tmux.conf".source = ./tmux.conf;
    ".gitconfig".source = ./gitconfig;
    ".Xresources".source = ./Xresources;
    ".tmux-workspace.sh".source = ./tmux-workspace.sh;
    # ".ssh/config".source = ./sshconfig;
  };

  xdg.configFile = {
    "alacritty/alacritty.yml".text = builtins.readFile ./alacritty.yml;
    "i3/config".text = builtins.readFile ./i3config;
    "i3/locker.sh".text = builtins.readFile ./i3locker.sh;
    "ls_color/ls.color".text = builtins.readFile ./ls.color;
    "polybar/launch.sh".text = builtins.readFile ./polybar_launch.sh;
    "polybar/forest/config.ini".text = builtins.readFile ./polybar_config.ini;
  };

  home.packages = [
    pkgs.neovim
    pkgs.bat
    pkgs.fzf
    pkgs.git-crypt
    pkgs.htop
    pkgs.jq
    pkgs.yq
    pkgs.rustup
    pkgs.tree
    pkgs.watch
    pkgs.bitwarden
    pkgs.bitwarden-cli

    pkgs.zlib
    pkgs.libelf

    pkgs.neofetch
    pkgs.flameshot
    pkgs.remmina
    pkgs.slack
    pkgs.arandr
    pkgs.ruby
    pkgs.silver-searcher
    pkgs.ripgrep
    pkgs.exa
    pkgs.glow
    pkgs.nodejs-16_x
    pkgs.cmake
    pkgs.gnumake
    pkgs.binutils
    pkgs.ctags
    pkgs.file
    pkgs.vagrant
    pkgs.nfs-utils
    pkgs.bridge-utils
    pkgs.go_1_18
    pkgs.gopls
    zoom
    pkgs.rofi
    pkgs.obsidian
    pkgs.bind
    pkgs.pavucontrol
    pkgs.vlc
    pkgs.brave

    pkgs.lens
    pkgs.rust-analyzer
    pkgs.light
    pkgs.zoxide

    pkgs.discord
    pkgs.pkg-config
    pkgs.openssl.dev
    pkgs.zlib
    pkgs.libelf
    pkgs.shellcheck

    pkgs.python311
    pkgs.inetutils
    pkgs.nmap

    pkgs.xclip
    pkgs.xsel
    pkgs.azure-cli
  ];

  # To make remote ssh extension work -
  # https://github.com/microsoft/vscode-remote-release/issues/648#issuecomment-503148523
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      ms-python.python
      ms-vscode.cpptools
      golang.go
      bbenoist.nix
      zhuangtongfa.material-theme
      eamodio.gitlens
      editorconfig.editorconfig
      ms-vscode-remote.remote-ssh
    ];
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";
}
