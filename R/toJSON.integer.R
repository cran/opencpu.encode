# TODO: Add comment
# 
# Author: jeroen
###############################################################################

setMethod("asJSON", "integer",
	function(x, container = TRUE, collapse = "\n  ", ...) {
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
