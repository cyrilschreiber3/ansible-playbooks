{pkgs, ...}: let
  name = "zsh-autosuggestions";
in
  pkgs.stdenv.mkDerivation {
    inherit name;

    src = pkgs.fetchFromGitHub {
      owner = "zsh-users";
      repo = "zsh-autosuggestions";
      rev = "v0.7.0";
      sha256 = "1g3pij5qn2j7v7jjac2a63lxd97mcsgw6xq6k5p7835q9fjiid98";
    };

    installPhase = ''
      runHook preInstall
      mkdir -p $out/share/zsh/plugins/${name}
      cp -r . $out/share/zsh/plugins/${name}/
      runHook postInstall
    '';
  }
