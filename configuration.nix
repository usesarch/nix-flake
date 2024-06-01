# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

  ];

  # Autoupgrade
  #system.autoUpgrade = {
  #  enable = true;
  #  operation = "boot";
  #  flake = "~/.dotfiles";
  #  #flags 
  #  dates = "weekly";
  #  #channel
  #};

  #GC
  #nix.settings.auto-optimize-store = true;
  #nix.optimise.automatic = true;
  #nix.gc = {
  #  automatic = true;
  #  dates = "weekly";
  #  options = "--delete-older-than 14d";
  #};

  #}
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 2;

  #Display Manager 
  #services.greetd = {
  # enable = true;
  #settings = {
  # default_session = {
  #  command =
  #   "${pkgs.greetd.tuigreet}/bin/tuigreet --time --time-format '%I:%M %p | %a # %h | %F' --cmd Hyprland";
  #user = "greeter";
  #};
  #};
  #};

  #config lightdm?
  services.xserver.displayManager.lightdm = {
    greeters.slick = {
      enable = true;
      #theme = "Adwaita";
      draw-user-backgrounds = true;
    };
    background = "/home/iblamefps/Downloads/f3ABtuv4.png";
  };

  ## Network
  networking.networkmanager.enable = true;
  networking.hostName = "laptop";

  # Timezone and Locale internationalization
  services.automatic-timezoned.enable = true;
  # time.timeZone = "Africa/Windhoek";

  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  ## System Daemons
  #Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  #Xorg
  services.xserver.enable = true;

  #User config (me!)
  users.users.iblamefps = {
    isNormalUser = true;
    home = "/home/iblamefps";
    extraGroups = [ "wheel" "networkmanager" ];
    uid = 1000;
    shell = pkgs.zsh;
  };

  #Allow Unfree Packages
  nixpkgs.config.allowUnfree = true;

  #Hyprland
  programs.hyprland.enable = true;

  #Waybar
  programs.waybar.enable = true;

  #Starship prompt 

  ##Thunar
  programs.thunar.enable = true;
  programs.xfconf.enable = true;
  services.tumbler.enable = true;
  services.gvfs.enable = true;

  #fonts 
  fonts.packages = with pkgs; [ nerdfonts ];

  ## zsh (global ? )
  programs = {
    zsh = {
      enable = true;
      zsh-autoenv.enable = true;
      syntaxHighlighting.enable = true;
      ohMyZsh = {
        enable = true;
        plugins = [ "git" "history" ];
      };
    };
  };

  nixpkgs.config.permittedInsecurePackages = [ "electron-25.9.0" ];

  #systemPackages (allowed unfree above ^ and nerdfonts also )
  environment.systemPackages = with pkgs; [
    #Main config
    zsh
    oh-my-zsh
    waybar
    swww
    kitty
    rofi-wayland
    rofi
    neovim
    eww-wayland
    hyprland
    wlogout
    wl-clipboard
    cliphist
    wl-clip-persist
    wl-screenrec
    grim
    slurp
    swappy
    mpv
    hyprpicker
    imv
    ranger
    ueberzug

    #apps & stuff
    zathura
    obsidian
    firefox-wayland
    discord
    nuclear
    octaveFull

    #spotify #better alternative?

    #ricing tools & none essentials
    #gammastep
    #avizo #Notifi daemon
    dunst
    libnotify
    hyprpaper

    #systemPackages
    networkmanager # includes nmtui
    blueman
    brightnessctl
    pipewire
    pavucontrol
    pulseaudio
    xwayland
    xwaylandvideobridge
    dropbox
    greetd.tuigreet

    #Linux tools
    xdg-utils
    #xdg-desktop-portal
    gnugrep
    ripgrep
    wget # gnu web geti
    fzf
    git
    #gtk 
    unzip
    w3m-nox
    tldr
    lazygit
    hyperfine
    procs # replace ps? written in rust
    cht-sh
    gping
    glances
    htop
    zenith
    zoxide
    scc
    thefuck
    eza #replace ls 
    duf 
    bat
    diff-so-fancy
    rm-improved
    tre-command
    bandwhich
    navi
    ffmpeg
    cpufetch
    lsd
    speedtest-cli
    surge
    rstudio
    lorien
  ];

  ##sound 
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

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
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
