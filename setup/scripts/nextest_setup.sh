#!/bin/bash

# Exit with 1 if NEXTEST_ENV isn't defined.
if [ -z "$NEXTEST_ENV" ]; then
	exit 1
fi

# Set the default logging to `info` for tests
echo "RUST_LOG=info" >>"$NEXTEST_ENV"
# echo "RUST_LOG=debug" >>"$NEXTEST_ENV"
echo "RUST_LOG_SPAN_EVENTS=full" >>"$NEXTEST_ENV"
