{
  description = "A declarative system installation";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    mainFlake = {
      url = "github:cyrilschreiber3/nixconfig";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.mypkgs.follows = "my-packages";
    };
    my-packages = {
      url = "github:cyrilschreiber3/nur-packages";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    mainFlake,
    my-packages,
  }: (
    flake-utils.lib.eachDefaultSystem
    (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          my-packages.overlays.default
        ];
      };

      zsh-autosuggestions = pkgs.callPackage ./packages/zsh-autosuggestions.nix {inherit pkgs;};
      zsh-interactive-cd = pkgs.callPackage ./packages/zsh-interactive-cd.nix {inherit pkgs;};
      zsh-syntax-highlighting = pkgs.callPackage ./packages/zsh-syntax-highlighting.nix {inherit pkgs;};
    in {
      packages.default = pkgs.buildEnv {
        name = "mainPackageCollection";
        paths = with pkgs;
          [
            # Fonts
            nerd-fonts.meslo-lg
            nerd-fonts.jetbrains-mono

            # Shell packages
            chroma
            fzf
            lsd
            oh-my-posh
            oh-my-zsh
            zsh

            # Utilities
            gnupg
            nix-output-monitor
            pinentry-curses
          ]
          ++ [
            mainFlake.packages.${system}.myOMPConfig

            zsh-autosuggestions
            zsh-interactive-cd
            zsh-syntax-highlighting
          ];

        extraOutputsToInstall = ["man" "doc"];
      };
    })
  );
}
