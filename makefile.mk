
# make files

Sources = Makefile .gitignore README.md

######################################################################

ms = ../makestuff
# -include $(ms)/git.def

##################################################################

### Makestuff

## Change this name to download a new version of the makestuff directory
Makefile: start.makestuff

msrepo = https://github.com/dushoff

%.makestuff:
	-cd $(dir $(ms)) && mv -f $(notdir $(ms)) .$(notdir $(ms))
	cd $(dir $(ms)) && git clone $(msrepo)/$(notdir $(ms)).git
	cd $(dir $(ms)) && git clone $(msrepo)/$(notdir $(ms)).git
	-cd $(dir $(ms)) && rm -rf $(ms) .$(notdir $(ms))
	touch $@

-include $(ms)/local.mk
-include local.mk
-include $(ms)/git.mk

-include $(ms)/visual.mk

# -include $(ms)/wrapR.mk
# -include $(ms)/oldlatex.mk
