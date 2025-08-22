# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

#let
#  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz";
#in

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  options = {
    #my.aribitrary.option = lib.mkOption {
    #  type = lib.types.str;
    #  #types include: anything, str, nonEmptyStr, bool, int, float, number, path, listOf (listof: any other type)
    #  default = "stuff";
    #};
  };

  config = {
    #my.arbitrary.option = "awesome";

    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Standardize on ZSH - by the way
    environment.shells = with pkgs; [ bash zsh fish ];
    users.defaultUserShell = pkgs.zsh;
    programs.zsh.enable = true;

    networking.hostName = "tns-slx-n10469"; # Define your hostname.
    # Pick only one of the below networking options.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

    # Set your time zone.
    time.timeZone = "America/Vancouver";

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Select internationalisation properties.
    #i18n.defaultLocale = "en_US.UTF-8";
    #console = {
    #  font = "Lat2-Terminus16";
    #  keyMap = "us";
    #  useXkbConfig = true; # use xkb.options in tty.
    #};

    # Enable the X11 windowing system.
    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;

      #displayManager.cosmic-greeter.enable = true;
      #desktopManager.cosmic.enable = true;

      #displayManager.lightdm.enable = true;
      #desktopManager.cinnamon.enable = true;
      #desktopManager.mate.enable = true;
      #desktopManager.xfce.enable = true;
      #desktopManager.budgie.enable = true;
      #desktopManager.deepin.enable = true;
      #desktopManager.pantheon.enable = true;
      #desktopManager.cde.enable = true;
      #desktopManager.lxqt.enable = true;
      #desktopManager.lumina.enable = true;

      #windowManager.qtile.enable = true;
    };

    fonts.fontconfig.enable = true;
    # Configure keymap in X11
    #services.xserver.xkb.layout = "us";
    #services.xserver.xkb.options = "eurosign:e,caps:escape";
    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable sound.
    #services.pulseaudio.enable = true;
    # OR
    services.pipewire = {
      enable = true;
      pulse.enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager).
    # services.libinput.enable = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.ron = {
      isNormalUser = true;
      description = "Ron Zayac";
      extraGroups = [ 
        "wheel" 
        "flatpak" 
        "disk" 
        "qemu" 
        "kvm" 
        "libvirtd" 
        "libvirtd" 
        "sshd" 
        "networkmanager" 
        "audio" 
        "video" 
      ]; 
      packages = with pkgs; [
        tree
      ];
    };
    users.users.tnsadmin = {
      isNormalUser = true;
      description = "TNS Admin";
      extraGroups = [
        "wheel" 
        "flatpak" 
        "disk" 
        "qemu" 
        "kvm" 
        "libvirtd" 
        "libvirtd" 
        "sshd" 
        "networkmanager" 
        "audio" 
        "video"
      ]; 
    };

    # List packages installed in system profile.
    # You can use https://search.nixos.org/ to find more packages (and options).
    environment.systemPackages = with pkgs; [
      vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      wget
      neovim
      #w3w
      #dmenu
      ##neofetch
      #starship
      alacritty
      btop
      pcmanfm
      chromium
      #cargo #rust package manager
      celluloid
      #dunst
      efibootmgr
      elinks
      #eww #custom midget maker - requires rustc and cargo
      feh
      flameshot
      flatpak
      floorp
      fontconfig
      freetype
      #fuse-common
      gedit
      git
      gh
      #gcc
      gnome-keyring
      gnugrep
      gnumake
      gparted
      #hugo #static website site generator
      kitty
      #libverto
      luarocks
      lxappearance
      mangohud
      nfs-utils
      #ninja #dev build system
      #nodejs
      nomacs
      openssl
      os-prober
      pavucontrol
      #picom #windo compositor for X
      pfetch
      polkit_gnome
      powershell
      #python3Full
      #python.pkgs.pip
      qemu
      ripgrep
      rofi
      sxhkd
      st
      stdenv
      synergy
      #swaycons
      tldr
      trash-cli
      unzip
      variety
      virt-manager
      xclip
      xdg-desktop-portal-gtk
      xfce.thunar
      xwallpaper
    ];


    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    services.openssh.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # Copy the NixOS configuration file and link it from the resulting system
    # (/run/current-system/configuration.nix). This is useful in case you
    # accidentally delete configuration.nix.
    # system.copySystemConfiguration = true;

    # This option defines the first version of NixOS you have installed on this particular machine,
    # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
    #
    # Most users should NEVER change this value after the initial install, for any reason,
    # even if you've upgraded your system to a new NixOS release.
    #
    # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
    # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
    # to actually do that.
    #
    # This value being lower than the current NixOS release does NOT mean your system is
    # out of date, out of support, or vulnerable.
    #
    # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
    # and migrated your data accordingly.
    #

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nix.settings.allowed-users = [ "@wheel" ];
    nixpkgs.config.allowUnfree = true;

    # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
    system.stateVersion = "25.05"; # Did you read the comment?

    # Auto Updates
    system.autoUpgrade.enable = true;
    system.autoUpgrade.dates = "weekly";
  
    # Auto Cleanup
    nix.gc.automatic = true;
    nix.gc.dates = "daily";
    nix.gc.options = "--delete-older-than 10d";
    nix.settings.auto-optimise-store = true;
  
    systemd.sleep.extraConfig = ''
      AllowSuspend=no
      AllowHibernation=no
      AllowHybridSleep=no
      AllowSuspendThenHibernate=no
    '';

 }; 

}

