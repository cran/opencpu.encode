# TODO: Add comment
# 
# Author: jeroen
###############################################################################


setMethod("toJSON", "logical",
	function(x, container = TRUE, collapse = "\n", ..., .level = 1L, .withNames=F) {
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
