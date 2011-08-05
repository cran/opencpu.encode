# TODO: Add comment
# 
# Author: jeroen
###############################################################################


setMethod("asJSON", "AsIs",
	function(x, container = TRUE, collapse = "\n", ...) {
		asJSON(structure(x, class = class(x)[-1]), container = container, collapse = collapse, ...)
	}
);
