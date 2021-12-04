{ config, lib, pkgs, ... }:

{
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
  };

  xdg.configFile = {
    "alacritty/alacritty.yml".text = builtins.readFile ./alacritty.yml;
    "i3/config".text = builtins.readFile ./i3config;
    "i3/locker.sh".text = builtins.readFile ./i3locker.sh;
    "ls_color/ls.color".text = builtins.readFile ./ls.color;
  };

  home.packages = [
    pkgs.bat
    pkgs.fzf
    pkgs.git-crypt
    pkgs.htop
    pkgs.jq
    pkgs.go
    pkgs.gopls
    pkgs.tree
    pkgs.watch
  ];

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
