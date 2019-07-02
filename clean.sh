shopt -s nullglob
array=(*.tex)
for i in "${array[@]}"
do
    echo "file found $i"
    basename $i
    echo "deleting files generated from xelatex"
    rm -f ${i%.tex}.aux
    rm -f ${i%.tex}.log
    rm -f ${i%.tex}.out
    rm -f ${i%.tex}.pdf
    echo "deleting ${i%.tex}.jpg image"
    rm -f images/${i%.tex}[a-zA-Z0-9.-]*.jpg
done
