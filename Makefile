PACKAGE=tex-vpat

SRC = texlive-vpat.tex

PDF = ${SRC:%.tex=%.pdf}

HTML = ${SRC:%.tex=%.html} ${SRC:%.tex=%.css}

all: ${PDF} ${HTML}

%.pdf: %.tex
	pdflatex $<
	while ( grep -q '^LaTeX Warning: Label(s) may have changed' $*.log) \
	do pdflatex $<; done


%.html: %.tex
	htlatex $<

%.css: %.tex
	htlatex $<

clean:
	$(RM)  *.log *.aux \
	*.cfg *.glo *.idx *.toc \
	*.ilg *.ind *.out *.lof \
	*.lot *.bbl *.blg *.gls *.cut *.hd \
	*.dvi *.ps *.thm *.tgz *.zip \
	*.4ht *.4ct *.4tc *.tmp *.idv *.lg *.xref

distclean: clean
	$(RM) ${PDF} ${HTML}

archive:  all clean
	COPYFILE_DISABLE=1 tar  -czvf ../$(PACKAGE).tgz --exclude '*~' \
	--exclude '*.tgz' --exclude '*.zip'  --exclude 2021tug \
	--exclude '.git*' --exclude '*.tar' \
	--transform 's/^./${PACKAGE}/' .; mv ../${PACKAGE}.tgz .
