# TODO: Add comment
# 
# Author: jeroen
###############################################################################

setOldClass("singlevalue")
setMethod("toJSON", "singlevalue",
	function(x, ...) {
		return(toJSON(unclass(x), container=FALSE, ...));			
	}
);
