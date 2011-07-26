# TODO: Add comment
# 
# Author: jeroen
###############################################################################

setMethod("toJSON", "integer",
	function(x, container = TRUE, collapse = "\n  ", ..., .level = 1L) {
		tmp <- as.character(x);

		if(any(missings <- !is.finite(x))){
			tmp[missings] <- "null";
		}		
		
		tmp <- paste(tmp, collapse = ", ");
		
		if(container) {
			tmp <- paste("[",tmp, "]");
		} 
		return(tmp);
	}
);
