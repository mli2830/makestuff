### Makestuff

### Hooks for the editor to set the default target
current: target

target pngtarget pdftarget vtarget acrtarget: now 

##################################################################

now:
	@echo $(BRANCH)

ms = ../makestuff

# Base files

Sources = Makefile LICENSE README.md .gitignore stuff.mk README.github.md

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

# Makefiles and resources for other projects

Sources += visual.mk oldlatex.mk RR.mk wrapR.mk perl.def compare.mk

Sources += newlatex.mk latexdeps.pl RR/pdf.mk

Sources += talk.mk $(wildcard talk/*.*)

######################################################################

# RR scripts

RRR = $(wildcard RR/*.R)
RRpl = $(wildcard RR/*.pl)

Sources += $(RRR) $(RRpl)

# wrapR scripts

wrapRR = $(wildcard wrapR/*.R)
wrapRpl = $(wildcard wrapR/*.pl)

Sources += $(wrapRR) $(wrapRpl)

include git.mk

######################################################################

# Developing newlatex

# include perl.def
# include newlatex.mk

# test.pdf: test.tex latexdeps.pl

# .deps/test.tex.d: test.tex latexdeps.pl
