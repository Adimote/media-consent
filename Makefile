PDFLATEXFLAGS=-halt-on-error -interaction nonstopmode

all: form.pdf

clean:
	rm -f *.aux *.lof *.log *.lot *.fls *.out *.toc *.fmt *.fot *.cb *.cb2 *.lol *.pdf


form.pdf: form.tex fig-SourceBots.pdf
	pdflatex $(PDFLATEXFLAGS) $<

fig-%.pdf: fig-%.svg
	svg2pdf $< $@

watch:
	make
	while true; do \
		inotifywait --event CLOSE_WRITE -q -r *.tex; \
		make; \
	done


.PHONY: all clean
