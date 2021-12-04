{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "fristonio";
  home.homeDirectory = "/home/fristonio";

  home.file.".vimrc".source = "./vimrc";
  home.file.".bashrc".source = "./bashrc";
  home.file.".tmux.conf".source = "./tmux.conf";
  home.file.".gitconfig".source = "./gitconfig";
  home.file.".config/alacritty/alacritty.yml".source = "alacritty.yml";
  home.file.".config/i3/config".source = "i3config";
  home.file.".config/i3/locker.sh".source = "i3locker.sh";
  home.file.".config/ls_color/ls.color".source = "ls.color";

  home.packages = [
    pkgs.tmux
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
