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

all: yb-book.pdf make-samples zip

yb-book.pdf: yb-book.tex yb-book.cls
	latexmk -pdf $<
	texsc $<
	texqc --ignore 'You have requested document class' \
		--ignore 'csquotes should be loaded after fvextra' \
		--ignore 'parboxrestore  has changed' $<

zip: yb-book.pdf yb-book.cls
	rm -rf package
	mkdir package
	cd package
	mkdir yb-book
	cd yb-book
	cp -r ../../yb-book-logo.pdf .
	cp ../../README.md .
	version=$$(cat ../../VERSION.txt)
	echo "Version is: $${version}"
	date=$$(date +%Y/%m/%d)
	echo "Date is: $${date}"
	cp ../../yb-book.cls .
	gsed -i "s|0\.0\.0|$${version}|" yb-book.cls
	gsed -i "s|00\.00\.0000|$${date}|" yb-book.cls
	cp ../../yb-book.tex .
	gsed -i "s|0\.0\.0|$${version}|" yb-book.tex
	gsed -i "s|00\.00\.0000|$${date}|" yb-book.tex
	cp ../../.latexmkrc .
	latexmk -pdf yb-book.tex
	rm .latexmkrc
	rm -rf _minted-* *.aux *.bbl *.bcf *.blg *.fdb_latexmk *.fls *.log *.run.xml *.out *.ind *.idx *.ilg
	mkdir samples
	cp ../../samples/*.tex samples
	cat yb-book.cls | grep RequirePackage | gsed -e "s/.*{\(.\+\)}.*/hard \1/" > DEPENDS.txt
	cd ..
	zip -r yb-book-$${version}.zip *
	cp yb-book-$${version}.zip ..
	cd ..

clean:
	git clean -dfX
	cd samples && make clean && cd ..

make-samples: samples/*.tex
	cd samples
	make
	cd ..
