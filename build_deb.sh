#!/bin/bash

set -e

git submodule init
git submodule update --depth 1

cp -r debian rust/

tar -czf rust.tar.gz rust

