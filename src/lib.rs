#![deny(clippy::all)]
#![deny(clippy::pedantic)]
#![deny(clippy::nursery)]
#![deny(clippy::cargo)]
#![allow(clippy::multiple_crate_versions)]

doc_comment::doctest!("../readme.md");

pub mod error;
pub mod package_json;
#[cfg(feature = "validate")]
mod utils;
pub use error::Error;
pub use error::Result;
pub use package_json::*;
#[cfg(feature = "validate")]
pub use validator;
