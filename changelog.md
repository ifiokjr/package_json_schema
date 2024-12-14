# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.3.0](https://github.com/ifiokjr/package_json_schema/compare/v0.2.2...v0.3.0) - 2024-12-14

### <!-- 0 -->🎉 Added

- [**breaking**] upgrade msrv

### <!-- 7 -->⚙️ Miscellaneous Tasks

- upgrade `validator` to latest

## [0.2.2](https://github.com/ifiokjr/package_json_schema/compare/v0.2.1...v0.2.2) - 2024-09-25

### <!-- 0 -->🎉 Added

- upgrade `validator` version and make changes

### <!-- 1 -->🐛 Bug Fixes

- set msrv to`1.70` supporting `once_cell` in `validator`
- update `typesVersion` field spec to match docs ([#3](https://github.com/ifiokjr/package_json_schema/pull/3))
- upgrade `indexmap` to v2 ([#4](https://github.com/ifiokjr/package_json_schema/pull/4))

### <!-- 5 -->🎨 Styling

- update formatting

### <!-- 7 -->⚙️ Miscellaneous Tasks

- ensure valid changelog name
- test and build against msrv
- automate releases
- use sed for version change
- rust versions

> [Compare](https://github.com/ifiokjr/package_json_schema/compare/0.2.1...HEAD)

## 0.2.1

- Use the `Repository` enum in the `repository` field [#2](https://github.com/ifiokjr/package_json_schema/pull/2)
- Update readme and crate documentation.

> [Compare](https://github.com/ifiokjr/package_json_schema/compare/0.2.0...0.2.1)

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
