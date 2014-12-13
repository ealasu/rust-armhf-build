#!/bin/bash

set -e

curl -O https://static.rust-lang.org/dist/rust-nightly.tar.gz
tar -xf rust-nightly.tar.gz

cd rust-nightly

mkdir build
cd build

../configure --target=arm-unknown-linux-gnueabihf
make

