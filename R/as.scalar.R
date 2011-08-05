# TODO: Add comment
# 
# Author: jeroen
###############################################################################

#' Add class 'scalar' to an object
#'
#' Function simply adds class 'scalar' to the object and returns it.
#' Objects of class 'scalar' of length 1 will be encoded as a json primitive instead of an array.
#' 
#' @export
#' @param obj the R object to classified as scalar.
#' @return The same R object
#'
#' @author Jeroen Ooms \email{jeroen.ooms@@stat.ucla.edu}
#' @examples asJSON(list(foo=123));
#' asJSON(list(foo=as.scalar(123)));
#' 

as.scalar <- function(obj){
	return(structure(obj, class=c("scalar",class(obj))));
}
