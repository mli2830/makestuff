%.go:
	$(MAKE) $*
	echo "xdg-open $* &" | tcsh

%.acr:
	$(MAKE) $*
	acroread /a "zoom=165" $* &

%.png: %.pdf
	convert $< $@

MVF = /bin/mv -f
MV = /bin/mv
CP = /bin/cp
CPF = /bin/cp -f
DIFF = diff
EDIT = gvim
RMR = /bin/rm -rf
LN = /bin/ln -s

copy = $(CP) $< $@
ccrib = $(CP) $(crib)/$@ .
convert = convert $< $@
