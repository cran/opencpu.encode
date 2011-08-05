# TODO: Add comment
# 
# Author: jeroen
###############################################################################

#This file is called AAA so that it will be run first.

#' Serialize an R object to JSON.
#'
#' This is a slightly modified version of the asJSON function in RJSONIO. This function is mostly for internal use. 
#' Please use opencpu.encode instead.
#'  
#' @importFrom RJSONIO fromJSON
#' @export fromJSON
#' @export asJSON
#'  
#' @aliases asJSON,ANY-method asJSON,AsIs-method asJSON,character-method asJSON,integer-method
#' asJSON,list-method asJSON,logical-method asJSON,matrix-method asJSON,NULL-method
#' asJSON,numeric-method asJSON,scalar-method
#' @param x the object to be serialized
#' @param container if the object always should be in a json array, even if it has length 1.
#' @param collapse 	a string that is used as the separator when combining the individual lines of the generated JSON content
#' @return A valid JSON string
#'
#' @note All encoded objects should pass the validation at www.jsonlint.org
#' @references
#' \url{http://www.jsonlint.org}
#' @author Jeroen Ooms \email{jeroen.ooms@@stat.ucla.edu}
#' @examples jsoncars <- opencpu.encode(cars);
#' cat(jsoncars);
#' identical(opencpu.decode(jsoncars), cars);


setGeneric("asJSON",
		function(x, container = TRUE, collapse = "\n", ...)  
			standardGeneric("asJSON"))
