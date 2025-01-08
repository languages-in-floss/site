#!/bin/bash

hugo_version="0.73.0"
po4a_version="0.60"

if [ -f "$(pwd)/hugo" ]
then
    echo "hugo already found, should be $hugo_version"
     ./hugo version
else
    echo "Get Hugo $hugo_version"
    archive_file="hugo_${hugo_version}_Linux-64bit.tar.gz"
    wget --quiet "https://github.com/gohugoio/hugo/releases/download/v$hugo_version/$archive_file"

    echo "Extract Hugo $hugo_version"
    tar -xf "$archive_file"
    rm "$archive_file"
fi

if [ -d "$(pwd)/po4a-$po4a_version/" ]; then
    echo "po4a $po4a_version already exists locally"
else
    echo "Get po4a $po4a_version"
    archive_file="po4a-$po4a_version.tar.gz"
    wget --quiet "https://github.com/mquinson/po4a/releases/download/v$po4a_version/$archive_file"

    echo "Extract po4a $po4a_version"
    tar -xf "$archive_file"
    rm "$archive_file"
fi


echo "Set paths for po4a $po4a_version"
export PATH="$(pwd)/po4a-$po4a_version/:$PATH"
export PERLLIB="$(pwd)/po4a-$po4a_version/lib"

echo "Run get-mentions.py"
# python3 get-mentions.py

echo "Update translated content"
# ./make-translated-content.sh

echo "Run hugo"
./hugo server
