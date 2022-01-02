# (The MIT License)
#
# Copyright (c) 2021 Yegor Bugayenko
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the 'Software'), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

.SHELLFLAGS = -e -x -c

.ONESHELL:

all: ybook.pdf make-samples zip

ybook.pdf: ybook.tex ybook.cls
	latexmk -pdf $<
	texsc $<
	texqc --ignore 'You have requested document class' $<

zip: ybook.pdf ybook.cls
	rm -rf package
	mkdir package
	cd package
	mkdir ybook
	cd ybook
	cp -r ../../images .
	cp ../../README.md .
	version=$$(cat ../../VERSION.txt)
	echo "Version is: $${version}"
	date=$$(date +%Y/%m/%d)
	echo "Date is: $${date}"
	cp ../../ybook.cls .
	gsed -i "s|0\.0\.0|$${version}|" ybook.cls
	gsed -i "s|00\.00\.0000|$${date}|" ybook.cls
	cp ../../ybook.tex .
	gsed -i "s|0\.0\.0|$${version}|" ybook.tex
	gsed -i "s|00\.00\.0000|$${date}|" ybook.tex
	cp ../../.latexmkrc .
	latexmk -pdf ybook.tex
	rm .latexmkrc
	rm -rf _minted-* *.aux *.bbl *.bcf *.blg *.fdb_latexmk *.fls *.log *.run.xml *.out *.ind *.idx *.ilg
	mkdir samples
	cp ../../samples/*.tex samples
	cat ybook.cls | grep RequirePackage | gsed -e "s/.*{\(.\+\)}.*/hard \1/" > DEPENDS.txt
	cd ..
	zip -r ybook.zip *
	cp ybook.zip ..
	cd ..

clean:
	git clean -dfX
	cd samples && make clean && cd ..

make-samples: samples/*.tex
	cd samples
	make
	cd ..
