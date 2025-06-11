{ pkgs }:

let
  skyscraper = (pkgs.skyscraper.override {
    enableXdg = true;
  }).overrideAttrs (_: {
    version = "3.17.3";
    src = pkgs.fetchFromGitHub {
      owner = "Gemba";
      repo = "skyscraper";
      rev = "refs/tags/3.17.3";
      hash = "sha256-vQkvIQnTonvEByZaUQbumfR9aSiakEvy4MLXvllztis=";
    };
  });
in
pkgs.mkShellNoCC {
  name = "bphenriques-retrohandhelds";
  meta.description = "My retro-handhelds utility scripts";
  packages = [
    pkgs.shellcheck   # Scripting sanity checks
    skyscraper        # Scrap media from roms
  ];
}

