# TODO: Add comment
# 
# Author: jeroen
###############################################################################


depackageObject <- function(obj, safe){
	
	encodes.data <- c("Date", "POSIXct", "POSIXlt", "NULL", "environment", "raw",
		"logical", "integer", "numeric", "double", "character", "complex", "list");
	encodes.language <- c("symbol", "name", "expression", "language", "function");
	
	if(obj$encode.mode %in% encodes.data){
		mydata <- switch(obj$encode.mode,
			"Date" = as.Date(strptime(obj$value, format="%Y-%m-%d")),
			"POSIXct" = as.POSIXct(strptime(obj$value, format="%Y-%m-%d %H:%M:%S")),
			"POSIXlt" = as.POSIXlt(strptime(obj$value, format="%Y-%m-%d %H:%M:%S")),
			"NULL" = NULL,
			"environment" = NULL,
			"raw" = base64.decode(unlist(obj$value)),
			"logical" = as.logical(null2na(obj$value)),
			"integer" = as.integer(null2na(obj$value)),
			"numeric" = as.numeric(null2na(obj$value)),
			"double" = as.double(null2na(obj$value)),
			"character" = as.character(null2na(obj$value)),
			"complex" = complex(real=obj$value$Re, imaginary=obj$value$Im),			
			"list" = lapply(obj$value, depackageObject, safe=safe),
			stop("Switch falling through for encode.mode: ", encode.mode)
		);
	} else if(obj$encode.mode %in% encodes.language){
		if(safe){
			mydata <- switch(obj$encode.mode,
				"symbol" = parse(text=unlist(obj$value)), #as.symbol will be evaluated by structure()
				"name" = parse(text=unlist(obj$value)),	#as.name will be evaluated by structure()
				"expression" = parse(text=obj$value),
				"language" = parse(text=unlist(obj$value)), #results in an expression
				"function" = parse(text=unlist(obj$value)), #results in an expression			
				stop("Switch falling through for encode.mode: ", encode.mode)			
			);	
		} else {
			mydata <- switch(obj$encode.mode,
				"symbol" = parse(text=unlist(obj$value)),
				"name" = parse(text=unlist(obj$value)),	
				"expression" = parse(text=obj$value),
				"language" = parse(text=unlist(obj$value)), #results in an expression
				"function" = eval(parse(text=unlist(obj$value))), #results in an evaluation!!	
				stop("Switch falling through for encode.mode: ", encode.mode)	
			);
		}
	}
	else {
		stop("Unknown encode.mode: ", encode.mode, "\n");
	}
	
	attrib <- lapply(obj$attributes, depackageObject, safe=safe);
	newdata <- list(.Data=mydata);
	do.call("structure", c(newdata, attrib));
}
