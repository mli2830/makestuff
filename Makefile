### Hooks for the editor to set the default target
current: target

target pngtarget pdftarget vtarget acrtarget: Makefile

##################################################################

# Base files

Sources = Makefile LICENSE README.md .gitignore

# Starting makefile for other projectcs

Sources += makefile.mk hooks.mk

# bootstrap the CP command; anything else?
ms = ../makestuff

# Bootstrap stuff
# Want to be able to change this stuff locally
%.mk: %.mk.template
	$(CP) $< $@

Sources += linux.mk windows.mk

######################################################################

# Git makefile for this and other projects

Sources += git.mk
include git.mk

# Makefiles and resources for other projects

Sources += visual.mk oldlatex.mk RR.mk

RRR = $(wildcard RR/*.R)
RRpl = $(wildcard RR/*.pl)

Sources += $(RRR) $(RRpl)
