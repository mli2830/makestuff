latex = pdflatex

# dvi is based on both .tex and .aux, and does complicated stuff, to try
# to figure out when it's done (and sometimes run twice with one make).

%.pdf: %.tex

%.ltx:
	$(latex) $*; sleep 1
	diff tmp.aux $*.aux > /dev/null || touch $@

%.aux: %.tex 
	touch $@
	/bin/cp -f $@ tmp.aux
	$(MAKE) $*.ltx

%.pdf: %.aux 
	diff tmp.aux $@ > /dev/null || $(MAKE) $*.ltx

# Make .pdf depend on .bbl when appropriate

%.bbl: %.aux 
	bibtex $*

tclean:
	$(RM) *.aux *.bbl

