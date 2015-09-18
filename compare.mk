%.std: 
	/bin/cp -f $* $@

%.compare: %.std
	$(MAKE) $*
	$(MVF) $* $*.new
	$(MV) $< $*
	$(DIFF) $*.new $* > $@
	$(RM) $*.new $@
