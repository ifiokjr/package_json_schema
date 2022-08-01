# package_json_schema

> Load json content `package.json` file

## Why?

You want to load a `package.json` file and interact with it as a struct.

## Installation

Add this line to the `dependencies` section of your `Cargo.toml`:

```toml
package_json_schema = "0.1.0"
```

If you would like to include validation then add the `validate` feature. This will validate all the fields the loaded json. Emails, the package name, the version.

```toml
package_json_schema = { version = "0.1.0", features = ["validate"] }
```

## Usage

The following example shows how to load a `package.json` file and use it as a struct.

```rust
use package_json_schema::PackageJson;

let contents = r###"
{
  "name": "my-package",
  "version": "0.1.0",
  "dependencies": {
    "@sveltejs/kit": "1.0.0-next.396"
  },
  "peerDependencies": {
    "aws-sdk": "2.1185.0"
  }
}
"###

let package_json = PackageJson::try_from(contents).unwrap();
assert_eq!(package_json.name, "my-package");
assert_eq!(package_json.version, "0.1.0");
```

A `package.json` file can also be created from a builder.

```rust
use package_json_schema::PackageJson;
use index_map::IndexMap;
use package_json::Person;

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

## License

This project is licensed under the [Unlicense license](LICENSE).
