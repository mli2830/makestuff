rrd = $(ms)/RR

PDFCHECK = $(rrd)/pdfcheck.pl
RR = $(rrd)/Rprep.pl
CW = $(rrd)/cw.pl
Rtrim = $(rrd)/Rtrim.pl

define run-R 
	perl -f $(RR) $@ $^ > $(@:.Rout=.RR)
	( (R --vanilla --args $($(@:.Rout=.Rargs)) < $(@:.Rout=.RR) > $(@:.Rout=.dmp)) 2> $(@:.Rout=.Rlog) && cat $(@:.Rout=.Rlog) ) || ! cat $(@:.Rout=.Rlog)
	perl -wf $(PDFCHECK) $@.pdf
	perl -wf $(Rtrim) $(@:.Rout=.dmp) > $@
	$(RM) $(@:.Rout=.dmp)
endef

.PRECIOUS: %.summary.Rout
%.summary.Rout: %.Rout $(rrd)/summary.R
	$(run-R)

.PRECIOUS: %.objects.Rout
%.objects.Rout: %.Rout $(rrd)/objects.R
	$(run-R)

# This one always works before the one below it
.PRECIOUS: %.Rout
%.Rout: %.R
	$(run-R)

.PRECIOUS: %.Rout.pdf
%.Rout.pdf: %.Rout ;

%.Rout.png: %.Rout.pdf
	/bin/rm -f $@
	convert $<[0] $@

%.Routput: %.Rout
	perl -f $(rrd)/Rcalc.pl $< > $@ 

.PRECIOUS: %.RData
%.RData: %.Rout ;

