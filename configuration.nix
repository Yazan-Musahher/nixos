{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.devices = [ "/dev/sda" ];

  # Networking
  networking.hostName = "yazan";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  # Configure keymap in X11
  services.xserver.layout = "no";

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.yazan = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    packages = with pkgs; [
      neovim
      chromium
      jetbrains.clion
      alacritty
      starship
      adementary-theme
      cmake
      gcc
      git
    ];
  };

  # Fonts
  fonts.fonts = with pkgs; [
    hack-font
    noto-fonts-emoji
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Firewall
  networking.firewall.enable = true;

  # System
  system.stateVersion = "22.05";
}
