### Hooks for the editor to set the default target
current: target

target pngtarget pdftarget vtarget acrtarget: Makefile

##################################################################

# Base files

Sources = Makefile LICENSE README.md .gitignore

# Starting makefile for other projectcs

Sources += makefile.mk

# bootstrap the CP command; anything else?
ms = ../makestuff
Sources += boot.mk
include boot.mk
-include $(ms)/local.mk

# Local.mk is made by hand from local.mk.template (maybe deprecate, for boot)
Sources += local.mk.template

# Bootstrap stuff
# Want to be able to change this stuff locally
%.mk: %.mk.template
	$(CP) $< $@

Sources += linux.mk.template windows.mk.template

######################################################################

# Git makefile for this and other projects

Sources += git.mk
include git.mk

# Makefiles for other projects

Sources += visual.mk oldlatex.mk
