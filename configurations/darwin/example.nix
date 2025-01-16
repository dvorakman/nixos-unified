# See /modules/darwin/* for actual settings
# This file is just *top-level* configuration.
{ flake, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    self.darwinModules.default
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";
  networking.hostName = "idios";

  # For home-manager to work.
  # https://github.com/nix-community/home-manager/issues/4026#issuecomment-1565487545
  users.users."cardinal".home = "/Users/cardinal";

  home-manager = {
    # Automatically move old dotfiles out of the way
    #
    # Note that home-manager is not very smart, if this backup file already exists it 
    # will complain "Existing file .. would be clobbered by backing up". To mitigate this,
    # we try to use as unique a backup file extension as possible.
    backupFileExtension = "nixos-unified-template-backup";

    # Enable home-manager for "cardinal" user
    users."cardinal" = {
      imports = [ (self + /configurations/home/cardinal.nix) ];
    };
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
