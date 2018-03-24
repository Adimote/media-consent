COMPILESVG=inkscape

PDFLATEXFLAGS=-halt-on-error -interaction nonstopmode

all: form.pdf

clean:
	rm -f *.aux *.lof *.log *.lot *.fls *.out *.toc *.fmt *.fot *.cb *.cb2 *.lol *.pdf


form.pdf: form.tex fig-SourceBots.pdf
	pdflatex $(PDFLATEXFLAGS) $<

fig-%.pdf: fig-%.svg
ifeq ($(COMPILESVG),inkscape)
	inkscape -A `pwd`/$@ `pwd`/$<
else
ifeq ($(COMPILESVG),svg2pdf)
	svg2pdf $< $@
else
	echo "Unknown COMPILESVG."; false
endif
endif

watch:
	make
	while true; do \
		inotifywait --event CLOSE_WRITE -q -r *.tex; \
			make; \
	make servercount; \
	done


.PHONY: all clean
