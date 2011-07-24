# TODO: Add comment
# 
# Author: jeroen
###############################################################################

#override toJSON.list to avoid the unpredictable boxing behaviour
setMethod("toJSON", "list",
	function(x, collapse = "\n", ..., .level = 1L) {
		# Emtpy list:
		if(length(x) == 0) {
			return(if(is.null(names(x))) "[]" else "{}")
		}
		
		els = sapply(x, toJSON, ..., .level = .level + 1L)
		
		if(all(sapply(els, is.name)))
			names(els) = NULL
		
		if(length(names(x))) {
			return(
				paste(
					sprintf("{%s", collapse),
					paste(dQuote(names(x)), els, sep = ": ", collapse = sprintf(",%s", collapse)),
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

