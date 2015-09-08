rm("input_files")
 
for(n in sort(objects())){
	o <- get(n)
	c <- class(o)
	cat(n, " (", c, ")", "\n", sep="")
	print(summary(o))
}
# rdnosave
