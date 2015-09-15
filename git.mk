
newpush: commit.txt
	git push -u origin master

push: commit.txt
	git push

pull: commit.txt
	git pull
	touch $<

sync: 
	$(MAKE) pull
	$(MAKE) push

commit.txt: $(Sources)
	git add $(Sources)
	echo "Autocommit ($(notdir $(CURDIR)))" > $@
	-git commit --dry-run >> $@
	gvim -f $@
	-git commit -F $@
	date >> $@

.gitignore:
	-/bin/cp $(ms)/$@ .

README.md:
	-/bin/cp $(ms)/README.github.md $@
	touch $@

remove:
	git rm $(remove)

forget:
	git reset --hard

# Clean all unSourced files (files with extensions only) from directory or repo
clean_repo:
	git rm --cached --ignore-unmatch $(filter-out $(Sources), $(wildcard *.*))

clean_dir:
	/bin/rm -f $(filter-out $(Sources), $(wildcard *.*))

clean_both: clean_repo clean_dir

# Test that you can make the current target with the Sources and the rules

testdir: $(Sources)
	-/bin/rm -rf $@_old
	-/bin/mv -f $@ $@_old
	mkdir $@
	mkdir $@/$(notdir $(CURDIR))
	/bin/cp -f $^ $@/$(notdir $(CURDIR))
	ln -s $(addprefix $(CURDIR)/, $(parallel)) $@
	cd $@/$(notdir $(CURDIR)) && $(MAKE)

subclone:
	-/bin/rm -rf subclone_dir
	mkdir subclone_dir
	grep url .git/config | perl -npe "s/url =/git clone/; s/.git$$//" | sh
