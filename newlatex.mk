latex = pdflatex

include $(wildcard .deps/*.d)

%.ltx:
	-/bin/cp -f $*.aux .$*.aux
	$(latex) $*; sleep 1
	diff .$*.aux $*.aux > /dev/null || touch $*.aux

.deps:
	mkdir $@

reset_deps:
	$(RM) deps/*.d

.PRECIOUS: %.aux
%.aux: %.tex .deps
	$(MAKE) .deps/$<.d
	touch $@
	$(MAKE) $*.ltx

.deps/%.d: % $(ms)/latexdeps.pl
	$(PUSHSTAR)

%.pdf: %.tex
	touch $<
	$(MAKE) $*.aux
	diff .$< $< > /dev/null || $(MAKE) $*.ltx

%.bbl: %.tex 
	$(MAKE) $*.ltx
	/bin/rm -f $@
	bibtex $*

tclean:
	$(RM) *.aux *.bbl
