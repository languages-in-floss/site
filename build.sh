#!/bin/bash

hugo_version="0.140.2"

if [ -f "$(pwd)/hugo" ] && "$(pwd)/hugo" version | grep -q "$hugo_version";
then
    echo "hugo already found and is version $hugo_version"
else
    echo "Get Hugo $hugo_version"
    rm -f -- "$(pwd)/hugo"
    archive_file="hugo_${hugo_version}_Linux-64bit.tar.gz"
    echo "https://github.com/gohugoio/hugo/releases/download/v$hugo_version/$archive_file"
    wget --quiet "https://github.com/gohugoio/hugo/releases/download/v$hugo_version/$archive_file"

    echo "Extract Hugo $hugo_version"
    tar -xf "$archive_file" hugo
    rm "$archive_file"
fi

echo "Run get-mentions.py"
python3 get-mentions.py

echo "Update translated content"
"$(pwd)"/make-translated-content.sh &> /dev/null

echo "Run hugo"
"$(pwd)"/hugo
