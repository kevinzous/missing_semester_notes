paper.pdf: paper.tex plot-data.png
	pdflatex paper.tex

plot-%.png: %.dat plot.py
	./plot.py -i $*.dat -o $@

.PHONY: clean
clean:
	rm plot-data.png paper.log paper.aux paper.pdf

.PHONY : install
install:
	# https://gist.github.com/rain1024/98dd5e2c6c8c28f9ea9d
	sudo apt-get install -y texlive-latex-base texlive-fonts-recommended texlive-fonts-extra texlive-latex-extra
	pip install matplotlib
