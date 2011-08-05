# TODO: Add comment
# 
# Author: jeroen
###############################################################################

#NOTE: opencpu.encode is never upposed to use this function, because it unclasses every object first.
# it is included for completeness.

setMethod("asJSON", "matrix",
	function(x, container = TRUE, collapse = "\n", ...) {
		tmp = paste(apply(x, 1, asJSON, ...), collapse = sprintf(",%s", collapse))
		if(!container){
			return(tmp);
		}
		paste("[", tmp, "]");
	}
);
