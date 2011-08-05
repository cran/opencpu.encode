# TODO: Add comment
# 
# Author: jeroen
###############################################################################


setMethod("asJSON", "logical",
	function(x, container = TRUE, collapse = "\n", ...) {
		tmp = ifelse(x, "true", "false");

		if(any(missings <- !is.finite(x))){
			tmp[missings] <- "null";
		}		

		if(container) {
			return(paste("[", paste(tmp, collapse = ", "), "]"));
		} else{
			return(tmp);
		}
	}
);
