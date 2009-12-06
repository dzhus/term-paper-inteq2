PDFLATEX := pdflatex -shell-escape
BIBTEX := bibtex8 -B
NOTANGLE := notangle
NOWEAVE := noweave -n
OCTAVE := octave

DOCNAME := paper

include ${DOCNAME}-deps.mk

.PHONY: doc clean

.PRECIOUS: %.out

${DOCNAME}-deps.mk: ${DOCNAME}.tex solution.tex
	texdepend -o $@ -print=if $<

${DOCNAME}.aux: ${DOCNAME}.tex ${DOCNAME}.bib ${INCLUDES}
	${PDFLATEX} ${DOCNAME}
	${BIBTEX} ${DOCNAME}

${DOCNAME}.pdf: ${DOCNAME}.aux
	${PDFLATEX} ${DOCNAME}
	${PDFLATEX} ${DOCNAME}

doc: ${DOCNAME}.pdf

solution.tex: solution.nw
	${NOWEAVE} $< > $@

solution.oct: solution.nw
	${NOTANGLE} $< > $@
	${OCTAVE} $@

%.out: solution.oct

%-plot.tex: %.out
	echo "\addplot file{$<};" > $@

%-val.out.tex: %.out
	cp $< $@

clean:
	@rm -frv `hg status --unknown --no-status`
