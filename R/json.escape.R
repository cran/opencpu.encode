# TODO: Add comment
# 
# Author: jeroen
###############################################################################


json.escape <- function(tmp){
	tmp = gsub('\\', '\\\\', tmp, fixed=T);
	tmp = gsub("\"", "\\\"", tmp, fixed=T);
	tmp = gsub("\n", "\\n", tmp, fixed=T);
	tmp = gsub("\r", "\\r", tmp, fixed=T);
	tmp = gsub("\t", "\\t", tmp, fixed=T);
	tmp = gsub("\a", "\\a", tmp, fixed=T);
	return(tmp);	
}
