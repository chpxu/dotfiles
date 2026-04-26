{ inputs, lib, ... }:
{

  flake-file.inputs.treefmt-nix = {
    url = lib.mkDefault "github:numtide/treefmt-nix";
    inputs.nixpkgs.follows = lib.mkDefault "nixpkgs";
  };
  flake-file.inputs.git-hooks-nix = {
    url = "github:cachix/git-hooks.nix/b68b780b69702a090c8bb1b973bab13756cc7a27";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  imports = [
    (inputs.treefmt-nix.flakeModule or { })
    (inputs.git-hooks-nix.flakeModule or { })
  ];

  perSystem =
    {
      self',
      lib,
      config,
      ...
    }:
    {
      packages.fmt = self'.formatter;
      pre-commit.settings.hooks = {
        nixfmt.enable = true;
        flake-checker = {
          enable = true;
          after = [ "treefmt-nix" ];
        };
        treefmt = {
          enable = true;
          package = config.treefmt.build.wrapper;
        };
      };
      treefmt = {
        projectRootFile = "flake.nix";
        programs = {
          nixfmt.enable = lib.mkDefault true;
          deadnix.enable = lib.mkDefault true;
          statix.enable = lib.mkDefault true;
          nixf-diagnose.enable = lib.mkDefault true;
          mdformat.enable = lib.mkDefault true;
          toml-sort.enable = lib.mkDefault true;
          prettier.enable = lib.mkDefault true;
          json-sort-cli.enable = lib.mkDefault true;
          xmllint.enable = lib.mkDefault true;
          shellcheck.enable = lib.mkDefault true;
        };
        settings = {
          on-unmatched = lib.mkDefault "fatal";
          global.excludes = [
            "LICENSE"
            "flake.lock"
            "*/flake.lock"
            ".envrc"
            ".direnv/*"
            "*/.gitignore"
            ".github/*"
            "Pictures/*"
            "result/*"
            "*.png"
            "*.jpg"
            "*.conf"
            "*.ini"
            "docs/fonts/*"
            "**/*.conf"
          ];
          formatter = {
            deadnix.priority = 1;
            statix.priority = 2;
            nixfmt = {
              priority = 3;
              strict = true;
              indent = 4;
            };
            mdformat = {
              wrap = 80;
              end-of-line = "lf";
            };
            json-sort-cli = {
              end-of-line = "lf";
              autofix = true;
              includes = [
                "*.json"
                "*.jsonc"
              ];
            };
            nixf-diagnose = {
              priority = 99;
            };
          };
        };
      };
    };

}
