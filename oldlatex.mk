latex = pdflatex

%.ltx:
	/bin/cp -f $*.aux .$*.aux
	$(latex) $*; sleep 1
	diff .$*.aux $*.aux > /dev/null || touch $*.aux

%.aux: %.tex 
	touch $@
	$(MAKE) $*.ltx

%.pdf: %.tex
	touch $<
	$(MAKE) $*.aux
	diff .$< $< > /dev/null || $(MAKE) $*.ltx

%.bbl: %.aux 
	/bin/rm -f $@
	bibtex $*

tclean:
	$(RM) *.aux *.bbl

