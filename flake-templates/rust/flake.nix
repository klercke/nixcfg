{
  inputs = {
    rust-overlay.url = "github:oxalica/rust-overlay/stable";
    cargo2nix =  {
      url = "github:cargo2nix/cargo2nix/release-0.12";
      inputs.rust-overlay.follows = "rust-overlay";
    };
    flake-utils.follows = "cargo2nix/flake-utils";
    nixpkgs.follows = "cargo2nix/nixpkgs";
  };

  outputs = inputs: with inputs;
    let
      projectName = "my-project"; # This needs to match package.name in Cargo.toml
    in
    # Build the output set for each default system and map system sets into
    # attributes, resulting in paths such as:
    # nix build .#packages.x86_64-linux.<name>
    flake-utils.lib.eachDefaultSystem ( system:
      let
        
        # Create nixpkgs containing rustBuilder from cargo2nix overlay
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ cargo2nix.overlays.default ];
        };

        # Create workspace and dependencies package set
        rustPkgs = pkgs.rustBuilder.makePackageSet {
          rustVersion = "1.93.0";
          packageFun = import ./Cargo.nix;
        };

        # Create workspace/dev shell
        workspaceShell = (rustPkgs.workspaceShell {
          packages = with pkgs; [
            rustc
            cargo
            rust-analyzer
            clippy
          ];
          RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}";
        });


      # Recursive output set for each system
      in rec {
        devShells = {
          default = workspaceShell;
        };

        # Package build
        packages = {
          # nix build .#${projectName}
          # nix build .#packages.x86_64-linux.${projectName}
          protochess = (rustPkgs.workspace.${projectName} {});
          # nix build
          default = packages.${projectName};
        };
      }
    );
}
