wrapRd = $(ms)/wrapR
RRd = $(ms)/RR

wrapR = $(wrapRd)/wrapR.pl
Rtrim = $(RRd)/Rtrim.pl

define run-R 
	perl -f $(wrapR) $@ $^ > $(@:.Rout=.wrapR.R)
	( (R --vanilla < $(@:.Rout=.wrapR.R) > $(@:.Rout=.wrapR.Rout)) 2> $(@:.Rout=.Rlog) && cat $(@:.Rout=.Rlog) ) || ! cat $(@:.Rout=.Rlog)
	perl -wf $(Rtrim) $(@:.Rout=.wrapR.Rout) > $@
endef

.PRECIOUS: %.summary.Rout
%.summary.Rout: %.Rout $(RRd)/summary.R
	$(run-R)

.PRECIOUS: %.objects.Rout
%.objects.Rout: %.Rout $(RRd)/objects.R
	$(run-R)

.PRECIOUS: %.Rout
%.Rout: %.R
	$(run-R)

.PRECIOUS: %.Rout.pdf
%.Rout.pdf: %.Rout ;

%.Rout.png: %.Rout.pdf
	/bin/rm -f $@
	convert $<[0] $@

%.Routput: %.Rout
	perl -f $(RRd)/Rcalc.pl $< > $@ 

.PRECIOUS: %.RData
%.RData: %.Rout ;

