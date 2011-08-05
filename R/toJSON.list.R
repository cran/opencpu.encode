# TODO: Add comment
# 
# Author: jeroen
###############################################################################

#override asJSON.list to avoid the unpredictable boxing behaviour
setMethod("asJSON", "list",
	function(x, collapse = "\n", ...) {
		# Emtpy list:
		if(length(x) == 0) {
			return(if(is.null(names(x))) "[]" else "{}")
		}
		
		els = sapply(x, asJSON, ...)
		
		if(all(sapply(els, is.name)))
			names(els) = NULL
		
		if(length(names(x))) {
			return(
				paste(
					sprintf("{%s", collapse),
					paste(dQuote(json.escape(names(x))), els, sep = ": ", collapse = sprintf(",%s", collapse)),
					sprintf("%s}", collapse)
				)
			);
		} else {
			return(
				paste(sprintf("[%s", collapse), paste(els, collapse = sprintf(",%s", collapse)), sprintf("%s]", collapse))
			);
		}
	}
);

