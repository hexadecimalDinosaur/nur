# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage

{ pkgs ? import <nixpkgs> { } }:

{
  # The `lib`, `modules`, and `overlays` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  android-unpinner = pkgs.callPackage ./pkgs/android-unpinner/default.nix { };
  flask-apscheduler = pkgs.callPackage ./pkgs/flask-apscheduler/default.nix { };
  fzf-tab-completion = pkgs.callPackage ./pkgs/fzf-tab-completion/default.nix { };
  jetbrains-fleet = pkgs.callPackage ./pkgs/jetbrains-fleet/default.nix { };
}
