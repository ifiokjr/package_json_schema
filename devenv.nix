{ pkgs, ... }:

{
  packages = [
    pkgs.cargo-insta
    pkgs.cargo-nextest
    pkgs.cargo-udeps
    pkgs.dprint
    pkgs.rustup
  ];

  # Scripts

  scripts."build:all".exec = ''
    set -e
    build:default
    build:features
  '';
  scripts."build:default".exec = ''
    set -e
    cargo build
  '';
  scripts."build:features".exec = ''
    set -e
    cargo build --all-features
  '';
  scripts."fix:all".exec = ''
    set -e
    fix:clippy
    fix:format
  '';
  scripts."fix:format".exec = ''
    set -e
    dprint fmt
  '';
  scripts."fix:clippy".exec = ''
    set -e
    cargo clippy --fix --allow-dirty --allow-staged
  '';
  scripts."lint:all".exec = ''
    set -e
    lint:format
    lint:clippy
  '';
  scripts."lint:format".exec = ''
    set -e
    dprint check
  '';
  scripts."lint:clippy".exec = ''
    set -e
    cargo clippy
    cargo check --all-features
  '';
  scripts."snapshot:review".exec = ''
    cargo insta review
  '';
  scripts."snapshot:update".exec = ''
    cargo nextest run
    cargo insta accept
  '';
  scripts."test:all".exec = ''
    set -e
    test:cargo
    test:docs
  '';
  scripts."test:cargo".exec = ''
    set -e
    cargo nextest run
    cargo nextest run --all-features
  '';
  scripts."test:docs".exec = ''
    set -e
    cargo test --doc
    cargo test --doc --all-features
  '';
  scripts."setup:ci".exec = ''
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
}
