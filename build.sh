#!/bin/bash

curl -O https://static.rust-lang.org/dist/rust-nightly.tar.gz
unzip rust-nightly.tar.gz

cd rust-nightly
mkdir build
cd build
../configure --target=arm-linux-gnueabihf
make

