{
  nixpkgs ? import ./nix/nixpkgs,
  pkgs ?
    let
      config = { allowUnfree = true; };
    in
      import nixpkgs { inherit config; },

  compiler ? "default",
  doBenchmark ? false,
}:

let
  hie = (pkgs.callPackage ./nix/pkgs/hie-nix {}).hie82;
  gitignore = pkgs.callPackage ./nix/pkgs/nix-gitignore {};

  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.${compiler};

  drv =
    let
      src = gitignore.gitignoreSourcePure ''
        **/**
        !*.cabal
      '' ./.;

      package = haskellPackages.callCabal2nix "app" src {};
    in package;

  env = pkgs.lib.overrideDerivation drv.env (oldAttrs: {
    buildInputs =
      oldAttrs.buildInputs ++
      (with pkgs; [ git watchexec hie ]) ++
      (with haskellPackages; [ cabal-install hlint hindent stylish-haskell ]);

    NIX_PATH = pkgs.lib.concatStringsSep ":" [
      "nixpkgs=${nixpkgs}"
    ];

    HISTFILE = toString ../.bash_hist;
  });
in
  env