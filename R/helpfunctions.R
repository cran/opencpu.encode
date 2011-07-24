#ENCODING TOOLS

# opposite of unname:
# force list into named list
# to get key/value json encodings
givename <- function(obj){
	return(structure(obj, names=as.character(names(obj))))
}

#trim whitespace
trim <-	function (x){ 
	gsub("(^[[:space:]]+|[[:space:]]+$)", "", x);
}

#put double quotes around a string
dQuote <- function(x){
	paste('"', x, '"', sep = "");
}



#DECODING TOOLS

evaltext <- function(text){
	return(eval(parse(text=text)))
}

null2na <- function(x){
	#parse explicitly quoted missing values
	missings <- x %in% c("NA", "Inf", "-Inf", "NaN");
	x[missings] <- lapply(x[missings], evaltext);
	
	#parse 'null' values
	x[sapply(x, is.null)] <- NA;
	return(unlist(x));
}