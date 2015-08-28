### Hooks for the editor to set the default target
current: target

target pngtarget pdftarget vtarget acrtarget: notarget

##################################################################

# Base files

Sources = Makefile LICENSE README.md

# Starting makefile for other projectcs

Sources += makefile.mk

ms = ../makestuff
include $(ms)/local.mk

# Local.mk is made by hand from local.mk.template
Sources += local.mk.template
include local.mk

# Bootstrap stuff
# Want to be able to change this stuff locally
%.mk: %.mk.template
	$(CP) $< $@

# Other makefiles

Sources += git.mk visual.mk

##################################################################

md = ../make/
rrd = ../RR/

local = default
-include $(md)/local.mk
-include $(md)/$(local).mk
-include $(rrd)/inc.mk

