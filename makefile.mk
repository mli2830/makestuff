
# make files

Sources = Makefile .gitignore

######################################################################

ms = ../makestuff

-include $(ms)/local.mk
-include local.mk
-include $(ms)/git.mk

-include visual.mk
# -include linux.mk

# -include oldlatex.mk
