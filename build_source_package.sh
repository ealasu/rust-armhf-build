#!/bin/bash

set -e

git submodule init
git submodule update --depth 1

cp -rf debian rust/

tar -czf rust-source.tar.gz rust

