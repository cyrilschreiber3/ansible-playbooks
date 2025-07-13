{pkgs, ...}: let
  name = "zsh-syntax-highlighting";
in
  pkgs.stdenv.mkDerivation {
    inherit name;

    src = pkgs.fetchFromGitHub {
      owner = "zsh-users";
      repo = "zsh-syntax-highlighting";
      rev = "0.8.0";
      sha256 = "1yl8zdip1z9inp280sfa5byjbf2vqh2iazsycar987khjsi5d5w8";
    };

    installPhase = ''
      runHook preInstall
      mkdir -p $out/share/zsh/plugins/${name}
      cp -r . $out/share/zsh/plugins/${name}/
      runHook postInstall
    '';
  }
