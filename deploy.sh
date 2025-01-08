#!/bin/bash

hugo_version="0.73.0"
po4a_version="0.60"

OLD=$(mktemp -d -t languages_in_floss_XXXX)
cd $OLD

function clean_tmp() {
  [ -n "$OLD" ] && rm -Rf "$OLD"
}

trap clean_tmp exit

echo "Get Hugo $hugo_version"
archive_file="hugo_${hugo_version}_Linux-64bit.tar.gz"
wget --quiet "https://github.com/gohugoio/hugo/releases/download/v$hugo_version/$archive_file"

echo "Extract Hugo $hugo_version"
tar -xf "$archive_file"
rm "$archive_file"

echo "Get po4a $po4a_version"
archive_file="po4a-$po4a_version.tar.gz"
wget --quiet "https://github.com/mquinson/po4a/releases/download/v$po4a_version/$archive_file"

echo "Extract po4a $po4a_version"
tar -xf "$archive_file"
rm "$archive_file"

echo "Set paths for po4a $po4av"
export PATH="$(pwd)/po4a-$po4av/:$PATH"
export PERLLIB="$(pwd)/po4a-$po4av/lib"

echo "Clone languages-in-floss/site"
git clone --quiet --recurse-submodules https://github.com/languages-in-floss/site website

cd website

echo "Run get-mentions.py"
python3 get-mentions.py

echo "Update translated content"
./make-translated-content.sh

echo "Run hugo"
../hugo

echo "copy rsync files"
rsync --quiet -az --chown=webapp2:webapp2 --delete public/ /var/www/my_webapp__2/www/
