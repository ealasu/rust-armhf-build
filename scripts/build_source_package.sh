#!/bin/bash
set -e

git submodule init
git submodule update --depth 1

date="$(date --date="$(cd rust && git show -s --format=%ci)" +%Y%m%d%H%M)"
hash="$(cd rust && git show -s --format=%h)"
echo "last commit: $date $hash"
version="$date~$hash~0ubuntu1"
echo "version: $version"

debchange --newversion "$version" --release 'Changes.'

rm -rf rust/debian
tar -cf rust-nightly-armhf_${version}.orig.tar.gz rust

cp -r debian rust/

(cd rust && debuild -S)

