{ pkgs, lib, ... }:

{
  packages =
    [
      pkgs.cargo-binstall
      pkgs.cargo-run-bin
      pkgs.coreutils
      pkgs.dprint
      pkgs.libiconv
      pkgs.nixfmt-rfc-style
      pkgs.rustup
      pkgs.shfmt
    ]
    ++ lib.optionals pkgs.stdenv.isDarwin (
      with pkgs.darwin.apple_sdk;
      [
        frameworks.CoreFoundation
        frameworks.Security
        frameworks.System
        frameworks.SystemConfiguration
      ]
    );

  scripts."install:all" = {
    exec = ''
      set -e
      cargo bin --install
    '';
    description = "Install all packages.";
  };
  scripts."update:deps" = {
    exec = ''
      set -e
      cargo update
      devenv update
      copy:js
    '';
    description = "Update dependencies.";
  };
  scripts."build:all" = {
    exec = ''
      set -e
      if [ -z "$CI" ]; then
        echo "Builing project locally"
        cargo build
        cargo build --all-features
      else
        echo "Building in CI"
        cargo build --locked
        cargo build --all-features --locked
      fi
    '';
    description = "Build all crates with all features activated.";
  };
  scripts."build:docs" = {
    exec = ''
      RUSTDOCFLAGS="--cfg docsrs" cargo doc --all-features
    '';
    description = "Build documentation site.";
  };
  scripts."fix:all" = {
    exec = ''
      set -e
      fix:clippy
      fix:format
    '';
    description = "Fix all fixable issues";
  };
  scripts."fix:format" = {
    exec = ''
      set -e
      dprint fmt
    '';
    description = "Format the files with dprint";
  };
  scripts."fix:clippy" = {
    exec = ''
      set -e
      cargo clippy --fix --allow-dirty --allow-staged --all-features
    '';
    description = "Fix all clippy issues";
  };
  scripts."lint:all" = {
    exec = ''
      set -e
      lint:format
      lint:clippy
    '';
    description = "Lint the whole codebase and fail if any issues found.";
  };
  scripts."lint:format" = {
    exec = ''
      set -e
      dprint check
    '';
    description = "Check that formatting is correct for the project.";
  };
  scripts."lint:clippy" = {
    exec = ''
      set -e
      cargo clippy
      cargo check --all-features
    '';
    description = "Check that lint rules are maintained for the entire project";
  };
  scripts."snapshot:update" = {
    exec = ''
      INSTA_UPDATE=always INSTA_FORCE_PASS=1 test:all
    '';
    description = "Update all snapshots when running the test suite.";
  };
  scripts."test:all" = {
    exec = ''
      set -e
      cargo test_default
      cargo test_all
      cargo test_docs_default
      cargo test_docs_all
    '';
    description = "Run all tests for the project.";
  };
  scripts."coverage:all" = {
    exec = ''
      set -e
      cargo coverage_default
      cargo coverage_all
      cargo coverage_docs_default
      cargo coverage_docs_all
      cargo coverage_codecov_report
    '';
    description = "Generate a coverage report for the project";
  };

  scripts."setup:ci" = {
    exec = ''
      set -e
      # update GitHub CI Path
      echo "$DEVENV_PROFILE/bin" >> $GITHUB_PATH
      echo "DEVENV_PROFILE=$DEVENV_PROFILE" >> $GITHUB_ENV

      # prepend common compilation lookup paths
      echo PKG_CONFIG_PATH=$PKG_CONFIG_PATH" >> $GITHUB_ENV
      echo LD_LIBRARY_PATH=$LD_LIBRARY_PATH" >> $GITHUB_ENV
      echo LIBRARY_PATH=$LIBRARY_PATH" >> $GITHUB_ENV
      echo C_INCLUDE_PATH=$C_INCLUDE_PATH" >> $GITHUB_ENV

      # these provide shell completions / default config options
      echo XDG_DATA_DIRS=$XDG_DATA_DIRS" >> $GITHUB_ENV
      echo XDG_CONFIG_DIRS=$XDG_CONFIG_DIRS" >> $GITHUB_ENV

      echo DEVENV_DOTFILE=$DEVENV_DOTFILE" >> $GITHUB_ENV
      echo DEVENV_PROFILE=$DEVENV_PROFILE" >> $GITHUB_ENV
      echo DEVENV_ROOT=$DEVENV_ROOT" >> $GITHUB_ENV
      echo DEVENV_STATE=$DEVENV_STATE" >> $GITHUB_ENV
    '';
    description = "";
  };
}
