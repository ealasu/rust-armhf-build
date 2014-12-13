#!/bin/bash

set -e

curl -O https://static.rust-lang.org/dist/rust-nightly.tar.gz
tar -xf rust-nightly.tar.gz

mkdir rust-nightly-build
cd rust-nightly-build

../rust-nightly/configure --target=arm-unknown-linux-gnueabihf
#make

cd ..

tar -czf rust-nightly-build.tar.gz ./rust-nightly-build

