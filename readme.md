# 📦️ package_json_schema

<br />

> Load a `package.json` file as a PackageJson `struct`.

<p align="center">
  <a href="https://crates.io/crates/package_json_schema">
    <img src="https://img.shields.io/crates/v/package_json_schema.svg" alt="Crate" title="Crate" />
  </a>
  <a href="https://docs.rs/package_json_schema">
    <img src="https://docs.rs/package_json_schema/badge.svg" alt="Docs" title="Docs" />
  </a>
  <a href="https://github.com/ifiokjr/package_json_schema/actions?query=workflow:ci">
    <img src="https://github.com/ifiokjr/package_json_schema/workflows/ci/badge.svg?branch=main" alt="Continuous integration badge for github actions" title="CI Badge" />
  </a>
  <a href="https://opensource.org/license/unlicense">
    <img src="https://img.shields.io/badge/license-Unlicence-blue.svg" alt="License" title="License" />
  </a>
</p>

<br />

## Why?

You want to load a `package.json` file and interact with it as a struct.

<br />

## Installation

Add this line to the `[dependencies]` section of your `Cargo.toml`:

```toml
package_json_schema = "0.2.0"
```

If you would like to include validation then add the `validate` feature.

```toml
package_json_schema = { version = "0.2.0", features = ["validate"] }
```

This adds the `validator` crate as a dependency and adds the `.validate()` method to the `PackageJson` struct. The fields are validated according to the [JSON schema specification](https://json.schemastore.org/package.json).

<br />

## Usage

The following example shows how to load a `package.json` file and use it as a struct.

```rust
use package_json_schema::PackageJson;

let contents = r###"
{
  "name": "my-package",
  "version": "0.2.0",
  "dependencies": {
    "@sveltejs/kit": "1.0.0-next.396"
  },
  "peerDependencies": {
    "aws-sdk": "2.1185.0"
  }
}
"###;

let package_json = PackageJson::try_from(contents).unwrap();
assert_eq!(package_json.name.unwrap(), "my-package");
assert_eq!(package_json.version.unwrap(), "0.2.0");
```

This crate leaves it to the user to load the `package.json` content from the filesystem. Here is an example of loading the file contents and parsing the contents into a struct.

```rust
use std::fs::read_to_string;
use package_json_schema::PackageJson;

let contents = read_to_string("./tests/fixtures/1/package.json").unwrap();
let package_json = PackageJson::try_from(contents).unwrap();

assert_eq!(package_json.name.unwrap(), "test");
```

A `package.json` file can also be created from a builder.

```rust
use package_json_schema::PackageJson;
use package_json_schema::AdditionalFields;
use package_json_schema::Person;
use indexmap::IndexMap;

let mut additional_fields: AdditionalFields = IndexMap::new();
additional_fields.insert("custom".into(), "value".into());

let package_json = PackageJson::builder()
  .name("awesome")
  .author(Person::String("Tester".into()))
  .other(additional_fields)
  .build();
let string_value = package_json.try_to_string().unwrap();

assert_eq!(
  string_value,
  r#"{"name":"awesome","author":"Tester","custom":"value"}"#
);
```

To validate the `package.json` fields, enable the `validate` feature.

```toml
package_json_schema = { version = "0.2.0", features = ["validate"] }
```

And then use the `validate` method.

```rust
use std::fs::read_to_string;
use package_json_schema::PackageJson;
#[cfg(feature = "validate")]
use validator::Validate;

let contents = read_to_string("./tests/fixtures/1/package.json").unwrap();
let package_json = PackageJson::try_from(contents).unwrap();

#[cfg(feature = "validate")]
package_json.validate().unwrap();
```

<br />

## Contributing

[`devenv`](https://devenv.sh/) is used to provide a reproducible development environment for this project. Follow the [getting started instructions](https://devenv.sh/getting-started/).

To automatically load the environment you should [install direnv](https://devenv.sh/automatic-shell-activation/) and then load the `direnv`.

```bash
# The security mechanism didn't allow to load the `.envrc`.
# Since we trust it, let's allow it execution.
direnv allow .
```

At this point you should see the `nix` commands available in your terminal.

### Upgrading `devenv`

If you have an outdated version of `devenv` you can update it by running the following commands. If you have an easier way, please create a PR and I'll update these docs.

```bash
nix profile list # find the index of the nxi package
nix profile remove <index>
nix profile install --accept-flake-config github:cachix/devenv/<version>
```

<br />

## License

This project is licensed under the [Unlicense license](license).
