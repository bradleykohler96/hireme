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
    # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
    GS=gswin64c.exe
else
    # Unknown.
    echo "no known operating system"
    GS=gs
fi

if ! type "$GS" > /dev/null; then
    echo "ghostscript not installed"
fi

SOURCE_DIR="src"
BUILD_DIR="build"
IMAGE_DIR="images"

shopt -s nullglob
array=($SOURCE_DIR/*.tex)
for i in "${array[@]}"
do
    echo "file found $i"
    echo "creating files generated from pdflatex"
    xelatex -interaction=nonstopmode -halt-on-error -file-line-error -quiet -include-directory=$SOURCE_DIR -output-directory=$BUILD_DIR $i
    if command -v $GS > /dev/null; then
    filename=$(basename $i)
    echo "creating ${filename%.tex}.jpg image for readme"
    $GS -q -dNOPAUSE -sDEVICE=jpeg -r400 -dJPEGQ=60 -sOutputFile=$IMAGE_DIR/${filename%.tex}-%03d.jpg $BUILD_DIR/${filename%.tex}.pdf -dBATCH
    fi
done
echo "done"
