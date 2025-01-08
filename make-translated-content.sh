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
keep="80" # the minimum percentage to translate a file

# place where the po files are
if [ -z "$PO_DIR" ] ; then
	PO_DIR="./l10n/po"
fi

# place where the localized files will be
if [ -z "$PUB_DIR" ] ; then
	PUB_DIR="./content-translated/"
fi


####################################
# TEST IF IT CAN WORK
####################################

if [ ! -d "$SRCDIR_MODULE" ] ; then
	echo "Please run this script from the documentation' root folder"
	exit 1
fi


####################################
# DEFINE ANTARA MODULES (md files)
####################################

use_po_module () {
	lang=$1

	while IFS= read -r -d '' file
	do
		basename=$(basename -s .md "$file")
		dirname=$(dirname "$file")
		path="${dirname#"$SRCDIR_MODULE"/}"

		if [ "$dirname" = "$SRCDIR_MODULE" ]; then
			potname=$basename
			localized_file="$PUB_DIR/$lang/$basename.md"
		else
			potname=$path/$basename
			localized_file="$PUB_DIR/$lang/$path/$basename.md"
		fi

		if [ ! -e "$PO_DIR/$lang/$potname.po" ]; then
			po4a-gettextize \
				--format text \
				--option markdown \
				--option yfm_keys=categories,tags,title \
				--master "$file" \
				--master-charset "UTF-8" \
				--po "$PO_DIR/$lang/$potname.po"
		fi

		po4a-translate \
			--format text \
			--option markdown \
			--option yfm_keys=categories,tags,title \
			--master "$file" \
			--master-charset "UTF-8" \
			--po "$PO_DIR/$lang/$potname.po" \
			--localized "$localized_file" --localized-charset "UTF-8" \
			--keep "$keep"
	done <   <(find -L "$SRCDIR_MODULE" -name "*.md"  -print0)
}

####################################
# HANDLE ANTARA MODULES (md files)
####################################

while IFS= read -r -d '' dir
do
	lang=$(basename -s .md "$dir")
	echo "$lang"
	use_po_module "$lang"
done <   <(find "$PO_DIR" -mindepth 1 -maxdepth 1 -type d -print0)

