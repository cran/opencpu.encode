# TODO: Add comment
# 
# Author: jeroen
###############################################################################


setMethod("asJSON", "character",
	function(x, container = TRUE, collapse = "\n", digits = 5, ...) {
		
		tmp <- x
		tmp <- json.escape(tmp);
		
		tmp = dQuote(tmp);
		
		tmp[is.na(x)] <- "null";
		tmp <- paste(tmp, collapse = ", ")
		if(container) {
			tmp <- paste("[", tmp, "]");
		}
		return(tmp);
	}
);
