# TODO: Add comment
# 
# Author: jeroen
###############################################################################


setMethod("toJSON", "character",
	function(x, container = TRUE, collapse = "\n", digits = 5, ..., .level = 1L) {
		
		tmp <- x
		tmp = gsub('\\', '\\\\', tmp, fixed=T);
		tmp = gsub("\"", "\\\"", tmp, fixed=T);
		tmp = gsub("\n", "\\\n", tmp, fixed=T);
		tmp = gsub("\r", "\\\r", tmp, fixed=T);
		tmp = gsub("\t", "\\\t", tmp, fixed=T);
		tmp = gsub("\a", "\\\a", tmp, fixed=T);
		
		tmp = dQuote(tmp);
		
		tmp[is.na(x)] <- "null";
		tmp <- paste(tmp, collapse = ", ")
		if(container) {
			tmp <- paste("[", tmp, "]");
		}
		return(tmp);
	}
);
