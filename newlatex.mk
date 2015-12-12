latex = pdflatex

include $(wildcard .deps/*.d)

%.ltx:
	-/bin/cp -f $*.aux .$*.aux
	$(latex) $*; sleep 1
	diff .$*.aux $*.aux > /dev/null || touch $*.aux

.deps:
	mkdir $@

## Does not work when you need it to (the loops go too deep)
reset_deps:
	-$(RM) .deps/*.d
	-$(RM) .deps/*.dd

.PRECIOUS: %.aux
%.aux: %.tex .deps
	perl -wf $(ms)/latexdeps.pl $< > .deps/$<.d
	touch $@
	$(MAKE) $*.ltx

### Not used. Leftover from a more aggressive paradigm.
.PRECIOUS: .deps/%.dd
.deps/%.dd: % $(ms)/latexdeps.pl
	$(PUSH)
	cp $@ .deps/$*.d

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
