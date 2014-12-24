#!/bin/bash

set -e

git submodule init
git submodule update --depth 1

tar -cf rust-source.tar rust
tar --append -f rust-source.tar --transform "s/^\./rust/" ./debian

