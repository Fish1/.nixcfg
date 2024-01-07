{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.kernelModules = [ "amdgpu" ];

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  services.printing.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.jacob = {
    isNormalUser = true;
    description = "Jacob Enders";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      pkgs.firefox
      pkgs.chromium
      pkgs.vscode
      pkgs.inkscape
      pkgs.indi-full
      pkgs.indilib
      pkgs.kstars
      pkgs.libsForQt5.breeze-icons
      pkgs.gimp
      pkgs.siril
    ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    pkgs.vim
    pkgs.neovim
    pkgs.zellij
    pkgs.gcc
    pkgs.kitty
    pkgs.unzip
    pkgs.gh
    pkgs.fish
    pkgs.steam
    pkgs.discord
    pkgs.lazygit
    pkgs.lazydocker
    pkgs.go
    pkgs.nodejs_18
    pkgs.python311Full
    pkgs.python311Packages.pip
    pkgs.gnumake
    pkgs.ansible
    pkgs.ffmpeg
    pkgs.libwebp
    pkgs.lsof
    pkgs.sysfsutils
    pkgs.libwebp
    pkgs.wget
  ];

  programs.fish.enable = true;
  programs.git = {
    enable = true;
    lfs.enable = true;
  };
  users.defaultUserShell = pkgs.fish;

  programs.steam.enable = true;
  programs.steam.remotePlay.openFirewall = true;
  programs.steam.dedicatedServer.openFirewall = true;

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  services.flatpak.enable = true;

  virtualisation.docker.enable = true;

  system.stateVersion = "23.11";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
