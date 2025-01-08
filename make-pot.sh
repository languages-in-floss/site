#!/bin/bash
po4a_version="0.73"

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
PATH="$(pwd)/po4a-$po4a_version/:$PATH"
export PATH
PERLLIB="$(pwd)/po4a-$po4a_version/lib"
export PERLLIB

# Display po4a version
po4a --version

####################################
# INITILIZE VARIABLES
####################################

# root of the documentation repository
SRCDIR_MODULE="./content/fr"

# place where to create the pot files
if [ -z "$POTDIR" ] ; then
    POTDIR="./l10n/pot"
fi

# place where the po files are
if [ -z "$PO_DIR" ] ; then
	PO_DIR="./l10n/po"
fi

####################################
# TEST IF IT CAN WORK
####################################

if [ ! -d "$SRCDIR_MODULE" ] ; then
    echo "Error, please check that SRCDIR match to the root of the documentation repository"
    echo "You specified modules are in $SRCDIR_MODULE"
    exit 1
fi


####################################
# HANDLE articles and pages
####################################

while IFS= read -r -d '' file
do
    basename=$(basename -s .md "$file")
    dirname=$(dirname "$file")
    path="${dirname#"$SRCDIR_MODULE"/}"

    if [ "$dirname" = "$SRCDIR_MODULE" ]; then
        potname=$basename.pot
    else
        potname=$path/$basename.pot
        mkdir -p "$POTDIR/$path"
    fi

    po4a-gettextize \
        --format text \
        --option markdown \
        --option yfm_keys=categories,tags,title \
        --master "$file" \
        --master-charset "UTF-8" \
        --po "$POTDIR/$potname"

done <   <(find -L "$SRCDIR_MODULE" -name "*.md" -print0)

echo "Done"
