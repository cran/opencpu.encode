# TODO: Add comment
# 
# Author: jeroen
###############################################################################


setMethod("toJSON", "logical",
	function(x, container = TRUE, collapse = "\n", NA_encode = TRUE, ..., .level = 1L) {
		tmp = ifelse(x, "true", "false");

		if(any(missings <- !is.finite(x))){
			if(NA_encode){
				tmp[missings] <- dQuote(tmp[missings]);
			} else {
				tmp[missings] <- "null";
			}
		}		

		if(container) {
			return(paste("[", paste(tmp, collapse = ", "), "]"));
		} else{
			return(tmp);
		}
	}
);
