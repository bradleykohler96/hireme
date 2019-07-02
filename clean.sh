#!/bin/bash
SOURCE_DIR="src"
BUILD_DIR="build"
IMAGE_DIR="images"

rm -rf $BUILD_DIR

shopt -s nullglob
array=($SOURCE_DIR/*.tex)
for i in "${array[@]}"
do
    echo "file found $i"
    echo "deleting files generated from xelatex"
    filename=$(basename $i)
    echo "deleting ${filename%.tex}.jpg image"
    rm -rf $IMAGE_DIR/${filename%.tex}[a-zA-Z0-9.-]*.jpg
done
echo "done"
