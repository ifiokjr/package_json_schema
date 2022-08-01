use lazy_static::lazy_static;
use regex::Regex;
use semver::VersionReq;
use validator::validate_email;
use validator::validate_url;
use validator::ValidationError;

lazy_static! {
  pub static ref PACKAGE_NAME_REGEX: Regex =
    Regex::new(r#"^(?:@[a-z0-9-*~][a-z0-9-*._~]*/)?[a-z0-9-~][a-z0-9-._~]*$"#).unwrap();
  pub static ref PACKAGE_MANAGER_REGEX: Regex =
    Regex::new(r#"(npm|pnpm|yarn)@\d+\.\d+\.\d+(-.+)?"#).unwrap();
}

pub fn validate_version(version: &str) -> Result<(), ValidationError> {
  VersionReq::parse(version)
    .map_err(|_| ValidationError::new("version must be a valid semver string"))?;

  Ok(())
}

pub fn validate_exports_path(path: &str) -> Result<(), ValidationError> {
  if path.starts_with("./") {
    Ok(())
  } else {
    Err(ValidationError::new("exports path must start with './'"))
  }
}

pub fn validate_email_or_url(email_or_url: &str) -> Result<(), ValidationError> {
  if validate_email(email_or_url) || validate_url(email_or_url) {
    Ok(())
  } else {
    Err(ValidationError::new("invalid email or url"))
  }
}
