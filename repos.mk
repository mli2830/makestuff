dushoff_github = https://github.com/dushoff
theobio_github_github = https://github.com/theobio

$(ms)/talk:
	cd $(dir $($@)) && git clone $(dushoff_github)/$(notdir $($@)).git

$(gitroot)/Disease_data:
	cd $(dir $($@)) && git clone $(theobio_github)/$(notdir $($@)).git
