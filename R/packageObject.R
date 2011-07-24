# TODO: Add comment
# 
# Author: jeroen
###############################################################################

packageObject <- function(obj, datetime_encode){
	#used for POSIXlt
	options("digits.secs" = 0);
	
	#Classes that have a custom encoding
	exceptions <- vector();
	if(datetime_encode) {
		if("POSIXlt" %in% class(obj)) {
			obj <- as.POSIXct(obj);
		}
		exceptions <- c(exceptions, c("POSIXct", "POSIXlt", "Date"))
	}
	
	#Test for exception
	isexception <- class(obj) %in% exceptions;
	if(any(isexception)){
		encoding.mode <- class(obj)[isexception][1];
	} else {
		encoding.mode <- storage.mode(obj);
	}
				
	return(
		list(
			encode.mode = structure(encoding.mode, class="singlevalue"), #singlevalue prevents boxing during toJSON
			attributes = givename(lapply(attributes(obj), packageObject, datetime_encode=datetime_encode)),
			value = switch(encoding.mode,
				"Date" = as.character(obj),
				"POSIXct" = as.character(obj),
				"POSIXlt" = as.character(obj),
				"NULL" = obj,
				"environment" = NULL,
				"raw" = base64.encode(unclass(obj)),
				"logical" = as.vector(unclass(obj), mode = "logical"),
				"integer" = as.vector(unclass(obj), mode = "integer"),
				"numeric" = as.vector(unclass(obj), mode = "numeric"),
				"double" = as.vector(unclass(obj), mode = "double"),
				"character" = as.vector(unclass(obj), mode = "character"),
				"list" = unname(lapply(obj, packageObject, datetime_encode=datetime_encode)),
				"language" = deparse(unclass(obj)),
				"function" = deparse(unclass(obj)),
				"name" = deparse(unclass(obj)),
				"symbol" = deparse(unclass(obj)),
				"complex" = list(Re=Re(as.vector(unclass(obj), mode = "complex")), Im=Im(as.vector(unclass(obj), mode = "complex"))),
				"expression" = as.character(unclass(obj)),					
				warning("No encoding has been defined for objects with encoding mode ",encoding.mode, " and will be skipped.")	
			)			
		)
	);	

}
