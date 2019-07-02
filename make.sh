if [[ "$OSTYPE" == "linux-gnu" ]]; then
    # ...
    GS=gs.exe
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac OSX
    GS=gs.exe
elif [[ "$OSTYPE" == "cygwin" ]]; then
    # POSIX compatibility layer and Linux environment emulation for Windows
    GS=gswin64c.exe
elif [[ "$OSTYPE" == "msys" ]]; then
    # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
    GS=gswin64c.exe
else
    # Unknown.
    echo "no known operating system"
    GS=""
fi

if ! type "$GS" > /dev/null; then
    echo "ghostscript not installed"
fi

shopt -s nullglob
array=(*.tex)
for i in "${array[@]}"
do
    echo "file found $i"
    echo "creating files generated from xelatex"
    xelatex -interaction nonstopmode -halt-on-error -file-line-error -quiet $i
    basename $i
    if command -v $GS > /dev/null; then
    echo "creating ${i%.tex}.jpg image for readme"
    "$GS" -q -dNOPAUSE -sDEVICE=jpeg -r400 -dJPEGQ=60 -sOutputFile=images/${i%.tex}-%03d.jpg ${i%.tex}.pdf -dBATCH
    fi
done
