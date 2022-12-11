# Changelog

## [Unreleased]

> [Compare](https://github.com/ifiokjr/package_json_schema/compare/0.2.0...HEAD)

## 0.2.0

> [2022-12-11](https://github.com/ifiokjr/package_json_schema/compare/0.1.2...0.2.0)

- Make versions of dependencies less strict, for better compatibility with other packages.
- Re-export the `validator` crate when the `validate` feature is enabled as requested in [#1](https://github.com/ifiokjr/package_json_schema/issues/1).

## 0.1.2

> [2022-08-01](https://github.com/ifiokjr/package_json_schema/compare/0.1.1...0.1.2)

Improve the readme documentation again.

## 0.1.1

> [2022-08-01](https://github.com/ifiokjr/package_json_schema/compare/0.1.0...0.1.1)

Small changes to the `readme.md`, which show up in `docs.rs`.

## 0.1.0

> [2022-08-01](https://github.com/ifiokjr/package_json_schema/compare/931629a...0.1.0)

Initial release of a `package.json` schema extractor.

### ✨ Features

- Transform a JSON string into a `PackageJson` struct.
- Optionally set the `validate` feature to validate the `package.json` fields.
