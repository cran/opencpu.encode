# TODO: Add comment
# 
# Author: jeroen
###############################################################################


base64.encode <- function(rawvec){
	myrawfile <- tempfile();
	mynewfile <- tempfile();
	
	writeBin(rawvec, myrawfile);
	base64::encode(myrawfile, mynewfile);
	encoding <-readLines(mynewfile);
	return(encoding);
}

base64.decode <- function(base64vec){
	myrawfile <- tempfile();
	mynewfile <- tempfile();
	
	writeBin(base64vec, mynewfile);
	base64::decode(mynewfile, myrawfile);
	rawvec <- readBin(myrawfile, "raw", n=file.info(myrawfile)$size);
	return(rawvec);
}