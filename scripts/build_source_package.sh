#!/bin/bash
set -e

rm -rf rust
git clone https://github.com/rust-lang/rust --depth=1

date="$(date --date="$(cd rust && git show -s --format=%ci)" +%Y%m%d%H%M)"
hash="$(cd rust && git show -s --format=%h)"
echo "last commit: $date $hash"
version="$date~$hash~utopic"
echo "version: $version"

tar -czf rust-nightly-armhf_${version}.orig.tar.gz rust

export DEBEMAIL='Emanuel Alasu <emanuel.alasu@gmail.com>'
debchange --newversion "$version" 'Changes.'
debchange --release 'Releasing.'
cp -r debian rust/

(cd rust && debuild -S)

