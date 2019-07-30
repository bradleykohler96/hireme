#!/bin/bash
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    # ...
    GS=gs
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac OSX
    GS=gs
elif [[ "$OSTYPE" == "cygwin" ]]; then
    # POSIX compatibility layer and Linux environment emulation for Windows
    GS=gswin64c.exe
elif [[ "$OSTYPE" == "msys" ]]; then
    # lightweight shell and GNU utilities compiled for Windows (part of MinGW)
    GS=gswin64c.exe
else
    # unknown
    echo "no known operating system"
    GS=
fi

if ! type "$GS" > /dev/null; then
    echo "ghostscript not installed"
fi

# the source directory
SOURCE_DIR="./src"
# the build directory relative to the project source
BUILD_DIR="../build"
# the image directory relative to the project source
IMAGE_DIR="../images"

echo "changing directory to ./$SOURCE_DIR"
cd "$SOURCE_DIR"

shopt -s nullglob
# make an array of source files ending with .tex
array=(./*.tex)
for i in "${array[@]}"
do
    echo "file found $i"
    echo "creating files generated from xelatex"
    # crate pdfs with xelatex
    xelatex -interaction=nonstopmode -halt-on-error -file-line-error -output-directory=$BUILD_DIR $i
    # check if ghostscript is availible
    if command -v $GS > /dev/null; then
    # find the file name
    filename=$(basename $i)
    # echo the file name ending in .jpg
    echo "creating ${filename%.tex}.jpg image for readme"
    # create the .jpg image using ghostscript
    $GS -q -dNOPAUSE -sDEVICE=jpeg -r400 -dJPEGQ=60 -sOutputFile=$IMAGE_DIR/${filename%.tex}-%03d.jpg $BUILD_DIR/${filename%.tex}.pdf -dBATCH
    fi
done
echo "done"
