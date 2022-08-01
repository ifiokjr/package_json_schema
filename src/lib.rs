#![deny(clippy::all)]
#![deny(clippy::pedantic)]
#![deny(clippy::nursery)]
#![deny(clippy::cargo)]

doc_comment::doc_comment! {
  include_str!("../readme.md")
}

pub mod error;
pub mod package_json;
#[cfg(feature = "validate")]
mod utils;

pub use error::Error;
pub use error::Result;
pub use package_json::*;
