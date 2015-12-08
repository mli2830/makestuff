### Git for _centralized_ workflow
### Trying to generalize now

### Diphthong
# Archimedes

cmain = dev

BRANCH = $(shell cat .git/HEAD | perl -npE "s|.*/||;")
-include $(BRANCH).mk

##################################################################

### Push and pull

newpush: commit.txt
	git push -u origin $(BRANCH)

push: commit.txt
	git push

pull: commit.txt
	git fetch
	git rebase origin/$(BRANCH)
	touch $<

#### Branching ####

### Trees are green

sync:
	$(MAKE) pull
	$(MAKE) push

commit.txt: $(Sources) $(Archive)
	git add $^
	echo "Autocommit ($(notdir $(CURDIR)))" > $@
	-git commit --dry-run >> $@
	gvim -f $@
	-git commit -F $@
	date >> $@

##################################################################

### Rebase

continue: $(Sources)
	git add $(Sources)
	git rebase --continue

abort:
	git rebase --abort

##################################################################

# Special files

.gitignore:
	-/bin/cp $(ms)/$@ .

README.md:
	-/bin/cp $(ms)/README.github.md $@
	touch $@

LICENSE.md:
	touch $@

local.mk:
	-/bin/cp $(gitroot)/local/local.mk .
	touch $@


##################################################################

### Cleaning

remove:
	git rm $(remove)

forget:
	git reset --hard

# Clean all unSourced files (files with extensions only) from directory or repo
clean_repo:
	git rm --cached --ignore-unmatch $(filter-out $(Sources), $(wildcard *.*))

clean_dir:
	-$(RMR) .$@
	mkdir .$@
	$(MV) $(filter-out $(Sources) local.mk $(wildcard *.makestuff), $(wildcard *.*)) .$@

clean_both: clean_repo clean_dir

$(Outside):
	echo Please get $@ (from somewhere outside the repo) and try again.
	exit 1

##################################################################

### Testing

testdir: $(Sources)
	-/bin/rm -rf .$@
	-/bin/mv -f $@ .$@
	mkdir $@
	mkdir $@/$(notdir $(CURDIR))
	tar czf $@/$(notdir $(CURDIR))/export.tgz $(Sources)
	cd $@/$(notdir $(CURDIR)) && tar xzf export.tgz
	-/bin/cp local.* $@/$(notdir $(CURDIR))
	cd $@/$(notdir $(CURDIR)) && $(MAKE)

subclone:
	$(MAKE) push
	-/bin/rm -rf subclone_dir
	mkdir subclone_dir
	cd subclone_dir && grep url ../.git/config | perl -npe "s/url =/git clone/; s/.git$$//" | sh
	d subclone_dir/* && $(MAKE) Makefile && $(MAKE)

##################################################################

# Branching

%.branch: sync
	git checkout $*

%.newbranch: sync
	-git branch -d $*
	git checkout -b $*
	$(MAKE) newpush

updatebranch: sync
	git rebase $(cmain) 

%.nuke:
	git branch -D $*
	git push origin --delete $*

upmerge: updatebranch
	git checkout $(cmain)
	git pull
	git merge $(BRANCH)
	git push
	$(MAKE) $(BRANCH).nuke
