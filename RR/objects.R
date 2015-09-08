rm("input_files")
 
for(n in sort(objects())){
	o <- get(n)
	c <- class(o)
	# p <- paste(n, " (", c, ")", sep="")
	cat(n, " (", c, ")", "\n", sep="")

	if (inherits(o, "data.frame") | inherits(o, "matrix") | inherits(o, "array")){
		cat(" ", dim(o), "\n", sep=" ")
	}
 
	if (c=="integer" | c== "logical" | c=="numeric" | c == "complex" | c=="character" | c=="raw" | c=="list"){
		cat(" ", length(o), "\n", sep=" ")
	}
 
	if (c=="function"){
		print(args(o))
	}
}
# rdnosave
