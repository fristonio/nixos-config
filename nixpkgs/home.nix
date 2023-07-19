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
    ".tmux.conf".source = ./tmux/tmux.conf;
    ".gitconfig".source = ./gitconfig;
    ".Xresources".source = ./Xresources;
    ".tmux-workspace.sh".source = ./tmux/tmux-workspace.sh;
    # ".ssh/config".source = ./sshconfig;
  };

  xdg.configFile = {
    "alacritty/alacritty.yml".text = builtins.readFile ./alacritty.yml;
    "i3/config".text = builtins.readFile ./i3/i3config;
    "i3/locker.sh".text = builtins.readFile ./i3/i3locker.sh;
    "ls_color/ls.color".text = builtins.readFile ./ls.color;
    "polybar/launch.sh".text = builtins.readFile ./polybar/polybar_launch.sh;
    "polybar/forest/config.ini".text = builtins.readFile ./polybar/polybar_config.ini;
    "set-wallpaper.sh".text = builtins.readFile ./polybar/set-wallpaper.sh;

    # NUSHELL configuration
    "nushell/config.nu".text = builtins.readFile ./nushell/config.nu;
    "nushell/env.nu".text = builtins.readFile ./nushell/env.nu;
    "nushell/onedark.nu".text = builtins.readFile ./nushell/onedark.nu;
    "nushell/atuin.nu".text = builtins.readFile ./nushell/atuin.nu;
    "nushell/zoxide.nu".text = builtins.readFile ./nushell/zoxide.nu;
  };

  home.packages = [
    pkgs.bat
    pkgs.exa
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
    pkgs.neovim

    pkgs.neofetch
    pkgs.flameshot
    pkgs.slack
    pkgs.arandr
    pkgs.ruby
    pkgs.silver-searcher
    pkgs.ripgrep
    pkgs.exa
    pkgs.glow
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
    pkgs.wireshark

    pkgs.xclip
    pkgs.xsel
    pkgs.azure-cli
    pkgs.rpi-imager

    ## Additional tools
    pkgs.delta
    pkgs.notepadqq
    pkgs.nushell
    pkgs.atuin
    pkgs.tldr
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
