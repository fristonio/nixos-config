{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  environment.pathsToLink = [ "/libexec" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.configurationLimit = 3;

  time.hardwareClockInLocalTime = true;

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "fristonio"; # Define your hostname.
  networking.networkmanager.enable = true;

  networking.useDHCP = false;
  networking.interfaces.wlo1.useDHCP = true;

  services.nfs.server.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    autorun = true;
    exportConfiguration = true;

    libinput.enable = true;
    libinput.touchpad = {
      naturalScrolling = true;
      scrollMethod = "twofinger";
      tapping = true;
    };

    windowManager.i3.enable = true;
    displayManager.lightdm = {
      enable = true;
    };
    videoDrivers = [ "displaylink" "modesetting" ];
  };

  services.tailscale.enable = true;

  nixpkgs.config = {
    packageOverrides = pkgs: rec {
      polybar = pkgs.polybar.override {
        i3Support = true;
      };
    };
  };


  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fonts = [
      pkgs.font-awesome-ttf
      pkgs.source-code-pro
      pkgs.powerline-fonts
      pkgs.fira-code
      pkgs.fira-code-symbols
      pkgs.nerdfonts
    ];
  };

  services.accounts-daemon.enable = true; # needed by lightdm

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;
  # environment.gnome.excludePackages = [ pkgs.gnome-photos pkgs.gnome.gnome-music pkgs.gnome.gnome-terminal pkgs.gnome.gedit pkgs.epiphany pkgs.evince pkgs.gnome.gnome-characters pkgs.gnome.totem pkgs.gnome.tali pkgs.gnome.iagno pkgs.gnome.hitori pkgs.gnome.atomix pkgs.gnome-tour ];

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.fristonio = {
     isNormalUser = true;
     extraGroups = [
       "wheel"
       "docker"
     ]; # Enable ‘sudo’ for the user.
  };

  users.users.guest = {
    isNormalUser = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    gcc
    stdenv
    llvm_13
    clang_13
    lld_13
    openssl_3_0
    bpftools
    google-chrome
    vim_configurable
    curl
    polybar
    libnotify
    xfontsel
    xclip
    alacritty
    tmux
    firefox
    git
    networkmanager_dmenu
    libdrm

    xlibs.xbacklight
    xlibs.xmodmap
    xlibs.xev
    xlibs.xinput
    xlibs.xmessage
    xlibs.xgamma
    xlibs.xset
    xlibs.xrandr
    xlibs.xrdb
    xlibs.xprop

    unzip
    gnome.nautilus
    pinentry
    pinentry-qt
    feh
    imagemagick
    xautolock
    i3lock-color
    home-manager
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh.enable = true;

  virtualisation = {
    docker.enable = true;

    virtualbox.host.enable = true;
    virtualbox.host.enableExtensionPack = true;
  };

  users.extraGroups.vboxusers.members = [ "fristonio" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}
