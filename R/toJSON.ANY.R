# TODO: Add comment
# 
# Author: jeroen
###############################################################################


setMethod("asJSON", "ANY",
	function(x, container = TRUE, collapse= "\n", ...) {
		if(isS4(x)) {
			paste("{", paste(dQuote(json.escape(slotNames(x))), sapply(slotNames(x), function(id) asJSON(slot(x, id), ...)), sep = ": "),
		"}", collapse = collapse)
		} else if(existsMethod("asJSON", class(unclass(x)))) {
			return(asJSON(unclass(x), container = container, collapse=collapse, ...));			
		} else {
			stop("No method for converting ", class(x), " to JSON");
		}
	}
);
