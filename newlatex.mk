latex = pdflatex

include $(wildcard .deps/*.d)

define ltx
	-/bin/cp -f $*.aux .$*.aux
	$(latex) $*; sleep 1
	diff .$*.aux $*.aux > /dev/null || touch $*.aux
endef

### Not using this now; we want an explicit rule for the .deps, for chaining
define ltxdeps
	perl -wf $(ms)/latexdeps.pl $*.tex > .deps/$*.tex.d
endef

.deps/%.tex.d: %.tex $(ms)/latexdeps.pl
	$(PUSH)

%.deps: .deps/%.d
	$(copy)

.deps:
	mkdir $@

## Does not work when you need it to (the loops go too deep)
## Or maybe it's better now without the .dd?
reset_deps:
	-$(RM) .deps/*.d
	-$(RM) .deps/*.dd

.PRECIOUS: %.aux
%.aux: %.tex .deps
	$(MAKE) .deps/$<.d
	touch $@
	$(ltx)

### Not used. Leftover from a more aggressive paradigm.
### The .dd is sabotage
.PRECIOUS: .deps/%.dd
.deps/%.dd: % $(ms)/latexdeps.pl
	$(PUSH)
	cp $@ .deps/$*.d

%.pdf: %.tex %.aux
	touch $<
	$(MAKE) $*.aux
#	diff .$< $< > /dev/null || $(MAKE) $*.ltx

%.bbl: %.tex 
	$(ltx)
	/bin/rm -f $@
	bibtex $*

tclean:
	$(RM) *.aux *.bbl
