### Hooks for the editor to set the default target
current: target

target pngtarget pdftarget vtarget acrtarget: Makefile

##################################################################

ms = ../makestuff

# Base files

Sources = Makefile LICENSE README.md .gitignore

# Starting makefile for other projectcs

Sources += makefile.mk hooks.mk

# Bootstrap stuff
# Want to be able to change this stuff locally
%.mk: %.mk.template
	$(CP) $< $@

Sources += linux.mk windows.mk

######################################################################

# Git makefile for this and other projects

Sources += git.mk git.def
include git.mk

# Makefiles and resources for other projects

Sources += visual.mk oldlatex.mk RR.mk wrapR.mk perl.def compare.mk

######################################################################

# RR scripts

RRR = $(wildcard RR/*.R)
RRpl = $(wildcard RR/*.pl)

Sources += $(RRR) $(RRpl)

# wrapR scripts

wrapRR = $(wildcard wrapR/*.R)
wrapRpl = $(wildcard wrapR/*.pl)

Sources += $(wrapRR) $(wrapRpl)
