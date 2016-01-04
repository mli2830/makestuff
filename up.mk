%.four.pdf: %.pdf
	pdftops $< - | psnup -4 -w7in -h7in | ps2pdf -dDEVICEWIDTHPOINTS=504 -dDEVICEHEIGHTPOINTS=504 - $@
