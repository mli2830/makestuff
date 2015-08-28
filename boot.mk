## The minimum stuff to get started in a system-agnostic way

uname := $(shell uname -s)
ifeq ($(uname),Linux)
	CP := /bin/cp -f
endif
