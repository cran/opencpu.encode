# TODO: Add comment
# 
# Author: jeroen
###############################################################################


setMethod("toJSON", "numeric",
	function(x, container = TRUE, collapse = "\n", digits = 5, NA_encode = TRUE, ..., .level = 1L) {
		tmp = trim(formatC(x, digits = digits));
		
		if(any(missings <- !is.finite(x))){
			if(NA_encode){
				tmp[missings] <- dQuote(tmp[missings]);
			} else {
				tmp[missings] <- "null";
			}
		}
		
		tmp <- paste(tmp, collapse = ", ");
		
		if(container) {
			tmp <- paste("[", tmp, "]")
		} 
		return(tmp);
	}
);