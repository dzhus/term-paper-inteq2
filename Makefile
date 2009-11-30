PDFLATEX := pdflatex -shell-escape
BIBTEX := bibtex8 -B
NOTANGLE := notangle
NOWEAVE := noweave -n
OCTAVE := octave

DOCNAME := paper

include ${DOCNAME}-deps.mk

.PHONY: doc clean

.PRECIOUS: %.out

${DOCNAME}-deps.mk: ${DOCNAME}.tex ${INCLUDES}
	texdepend -o $@ -print=if $<

${DOCNAME}.aux: ${INCLUDES} ${DOCNAME}.tex ${DOCNAME}.bib
	${PDFLATEX} ${DOCNAME}
	${BIBTEX} ${DOCNAME}

${DOCNAME}.pdf: ${DOCNAME}.aux
	${PDFLATEX} ${DOCNAME}
	${PDFLATEX} ${DOCNAME}

doc: ${DOCNAME}.pdf

%.out: solution.oct

%-plot.tex: %.out solution.oct
	echo "\addplot file{$<};" > $@

%-val.out.tex: %.out solution.oct
	cp $< $@

solution.oct: solution.oct.nw
	${NOTANGLE} $< > $@
	${OCTAVE} $@

solution.oct.tex: solution.oct.nw
	${NOWEAVE} $< > $@

clean:
	@rm -frv `hg status --unknown --no-status`
