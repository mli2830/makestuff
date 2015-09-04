
newpush: commit.txt
	git push -u origin master

push: commit.txt
	git push

pull: commit.txt
	git pull
	touch $<

commit.txt: $(Sources)
	git add $(Sources)
	echo Autocommit > $@
	-git commit --dry-run >> $@
	gvim -f $@
	-git commit -F $@
	date >> $@

remove:
	git rm $(remove)

forget:
	git reset --hard

# Clean all unSourced files (files with extensions only)
clean_repo:
	git rm --cached --ignore-unmatch $(filter-out $(Sources), $(wildcard *.*))

clean_dir:
	/bin/rm -f $(filter-out $(Sources), $(wildcard *.*))
