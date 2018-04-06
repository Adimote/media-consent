HAS_INKSCAPE := $(shell inkscape --version 2>/dev/null)
HAS_SVG2PDF := $(shell svg2pdf --version 2>/dev/null)

PDFLATEXFLAGS=-halt-on-error -interaction nonstopmode

all: form.pdf

clean:
	rm -f *.aux *.lof *.log *.lot *.fls *.out *.toc *.fmt *.fot *.cb *.cb2 *.lol *.pdf


form.pdf: form.tex fig-SourceBots.pdf
	pdflatex $(PDFLATEXFLAGS) $<

fig-%.pdf: fig-%.svg
ifdef HAS_INKSCAPE
	inkscape -A `pwd`/$@ `pwd`/$<
else
ifdef HAS_SVG2PDF
	svg2pdf $< $@
else
	echo "No supported SVG build tools available"; false
endif
endif

watch:
	make
	while true; do \
		inotifywait --event CLOSE_WRITE -q -r *.tex; \
		make; \
	done


.PHONY: all clean
