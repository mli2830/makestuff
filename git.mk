
newpush: commit.time
	git push -u origin master

push: commit.time
	git push

pull: commit.time
	git pull
	touch $<

commit.time: $(Sources)
	date > $@
	git add $(Sources)
	$(MAKE) gitcomment.txt
	git commit -F gitcomment.txt
	date > $@

gitcomment.txt: $(Sources)
	echo Autocommit > $@
	git commit --dry-run >> $@
	gvim -f gitcomment.txt

remove:
	git rm $(remove)

forget:
	git reset --hard

clean_repo_ext:
	git rm --cached --ignore-unmatch $(filter-out $(Sources), $(wildcard *.*))

clean_main_dir:
	/bin/rm -f $(filter-out $(Sources), $(wildcard *.*))
