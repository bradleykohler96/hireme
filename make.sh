shopt -s nullglob
array=(*.tex)

for i in "${array[@]}"
do
	xelatex -interaction nonstopmode -halt-on-error -file-line-error -quiet $i
	basename $i
	gswin64c.exe -q -dNOPAUSE -sDEVICE=jpeg -r400 -dJPEGQ=60 -sOutputFile=images/${i%.tex}-%03d.jpg ${i%.tex}.pdf -dBATCH
done
