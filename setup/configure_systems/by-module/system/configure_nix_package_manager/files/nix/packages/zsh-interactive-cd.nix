{pkgs, ...}: let
  name = "zsh-interactive-cd";
in
  pkgs.stdenv.mkDerivation {
    inherit name;

    src = pkgs.fetchFromGitHub {
      owner = "mrjohannchang";
      repo = "zsh-interactive-cd";
      rev = "master";
      sha256 = "1x1387zkzhzsnllvpciwnscvm3z77znlwsxrfkxjzvi8bz1w8vcg";
    };

    installPhase = ''
      runHook preInstall
      mkdir -p $out/share/zsh/plugins/${name}
      cp -r . $out/share/zsh/plugins/${name}/
      runHook postInstall
    '';
  }
