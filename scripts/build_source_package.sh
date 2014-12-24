#!/bin/bash
set -e

#git clone https://github.com/rust-lang/rust --depth=1
#(cd rust && git submodule sync)
#(cd rust && git submodule init)
#(cd rust && git submodule update --recursive)

#date="$(date --date="$(cd rust && git show -s --format=%ci)" +%Y%m%d%H%M)"
date="$(date +%Y%m%d%H%M)"
#hash="$(cd rust && git show -s --format=%h)"
#echo "last commit: $date $hash"
version="$date~0utopic1"
echo "version: $version"

orig="rust-nightly-armhf_${version}.orig.tar.gz"
curl -O https://static.rust-lang.org/dist/rust-nightly.tar.gz
rm -rf rust-nightly
tar -xf rust-nightly.tar.gz

mkdir rust-nightly/dl
archs=( x86_64-unknown-linux-gnu i686-unknown-linux-gnu )
for triple in "${archs[@]}" ; do
  echo "getting stage0 for $triple"
  mkdir -p rust-nightly/${triple}/stage0/bin
  (cd rust-nightly && CFG_SRC_DIR=$(pwd) ./src/etc/get-snapshot.py $triple)
done

tar -czf $orig rust-nightly

export DEBEMAIL='Emanuel Alasu <emanuel.alasu@gmail.com>'
debchange --newversion "$version" 'Changes.'
debchange --release 'Releasing.'
cp -r debian rust-nightly/

(cd rust-nightly && debuild -S)

