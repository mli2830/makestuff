
push: commit.time
	git push -u origin master

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

