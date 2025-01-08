#!/bin/bash

hugo_version="0.140.3"

if [ -f "$(pwd)/hugo" ]
then
    echo "hugo already found, should be $hugo_version"
     ./hugo version
else
    echo "Get Hugo $hugo_version"
    archive_file="hugo_${hugo_version}_Linux-64bit.tar.gz"
    wget --quiet "https://github.com/gohugoio/hugo/releases/download/v$hugo_version/$archive_file"

    echo "Extract Hugo $hugo_version"
    tar -xf "$archive_file" hugo
    rm "$archive_file"
fi

echo "Run get-mentions.py"
python3 get-mentions.py

echo "Update translated content"
./make-translated-content.sh &> /dev/null

echo "Run hugo"
./hugo server
