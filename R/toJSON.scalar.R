# TODO: Add comment
# 
# Author: jeroen
###############################################################################

setOldClass("scalar")
setMethod("asJSON", "scalar",
	function(x, ...) {
		if(length(x) ==1){
			return(asJSON(unclass(x), container=FALSE, ...));
		} else {
			return(asJSON(unclass(x), ...));
		}
	}
);
