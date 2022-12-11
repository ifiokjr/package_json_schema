use std::fs::read_to_string;

use indexmap::IndexMap;
use package_json_schema::AdditionalFields;
use package_json_schema::PackageJson;
use package_json_schema::Person;

#[test]
fn parse_package_json_file() {
  let contents = read_to_string("./tests/fixtures/1/package.json").unwrap();
  let package_json = PackageJson::try_from(contents).unwrap();

  assert_eq!(package_json.name.unwrap(), "test");
  insta::assert_json_snapshot!(package_json.other, @"{}");
}

#[test]
fn parse_package_json_file_additional_fields() {
  let contents = read_to_string("./tests/fixtures/2/package.json").unwrap();
  let package_json = PackageJson::try_from(contents).unwrap();

  insta::assert_json_snapshot!(package_json.other, @r###"
  {
    "extra": "1",
    "superCustom": "2",
    "even_without-camel_casing": true
  }
  "###);
}

#[test]
fn parse_package_json_file_with_dependencies() {
  let contents = read_to_string("./tests/fixtures/3/package.json").unwrap();
  let package_json = PackageJson::try_from(contents).unwrap();

  insta::assert_json_snapshot!(package_json, @r###"
  {
    "version": "0.1.0",
    "dependencies": {
      "@sveltejs/kit": "1.0.0-next.396"
    },
    "peerDependencies": {
      "aws-sdk": "2.1185.0"
    }
  }
  "###);
}

#[test]
fn create_package_json_file_with_builder_pattern() {
  let mut additional_fields: AdditionalFields = IndexMap::new();
  additional_fields.insert("custom".into(), "value".into());

  let package_json = PackageJson::builder()
    .name("awesome")
    .author(Person::String("Tester".into()))
    .other(additional_fields)
    .build();

  insta::assert_json_snapshot!(package_json, @r###"
  {
    "name": "awesome",
    "author": "Tester",
    "custom": "value"
  }
  "###
  );
}

#[cfg(feature = "validate")]
#[test]
fn invalid_name_field() {
  use package_json_schema::validator::Validate;

  let contents = read_to_string("./tests/fixtures/4/package.json").unwrap();
  let package_json = PackageJson::try_from(contents).unwrap();
  assert!(package_json.validate().is_err());
}
