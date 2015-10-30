%.go:
	$(MAKE) $*
	echo "xdg-open $* &" | tcsh

%.acr:
	$(MAKE) $*
	acroread /a "zoom=165" $* &

MVF = /bin/mv -f
MV = /bin/mv
CP = /bin/cp
CPF = /bin/cp -f
DIFF = diff
EDIT = gvim
