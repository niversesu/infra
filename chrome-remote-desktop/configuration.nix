{ config, pkgs, ... }:

{ 
   imports =
     [
       ./chrome-remote-desktop.nix
     ];

   environment.systemPackages = with pkgs; [
     chromium
   ];
   
   # List services that you want to enable:
   services = {
     chrome-remote-desktop = {
       enable = true;
       user = "sepiabrown";
     };
   };
   
   nixpkgs.overlays = [
     (self: super: {
       chrome-remote-desktop = super.callPackage ./default.nix {};
     })
   ];
}
  