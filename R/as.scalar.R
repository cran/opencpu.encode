# TODO: Add comment
# 
# Author: jeroen
###############################################################################


as.scalar <- function(obj){
	return(structure(obj, class=c(class(obj),"scalar")));
}
