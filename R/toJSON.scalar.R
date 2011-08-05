# TODO: Add comment
# 
# Author: jeroen
###############################################################################

setOldClass("scalar")
setMethod("asJSON", "scalar",
	function(x, ...) {
		return(asJSON(unclass(x), container=FALSE, ...));			
	}
);
