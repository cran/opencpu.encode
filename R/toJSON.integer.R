# TODO: Add comment
# 
# Author: jeroen
###############################################################################

setMethod("toJSON", "integer",
	function(x, container = TRUE, collapse = "\n  ", NA_encode = TRUE, ..., .level = 1L) {
		tmp <- as.character(x);

		if(any(missings <- !is.finite(x))){
			if(NA_encode){
				tmp[missings] <- dQuote(tmp[missings]);
			} else {
				tmp[missings] <- "null";
			}
		}		
		
		tmp <- paste(tmp, collapse = ", ");
		
		if(container) {
			tmp <- paste("[",tmp, "]");
		} 
		return(tmp);
	}
);
