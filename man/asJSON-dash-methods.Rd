\name{asJSON-methods}
\alias{asJSON-methods}
\alias{asJSON}
\title{Serialize an R object to JSON.}
\description{Serialize an R object to JSON.}
\details{This is a slightly modified version of the asJSON function in RJSONIO. This function is mostly for internal use. 
Please use opencpu.encode instead.}
\alias{asJSON,ANY-method}
\alias{asJSON,AsIs-method}
\alias{asJSON,character-method}
\alias{asJSON,integer-method}
\alias{asJSON,list-method}
\alias{asJSON,logical-method}
\alias{asJSON,matrix-method}
\alias{asJSON,NULL-method}
\alias{asJSON,numeric-method}
\alias{asJSON,scalar-method}
\value{A valid JSON string}
\note{All encoded objects should pass the validation at www.jsonlint.org}
\references{\url{http://www.jsonlint.org}}
\author{Jeroen Ooms \email{jeroen.ooms@stat.ucla.edu}}
\arguments{\item{x}{the object to be serialized}
\item{container}{if the object always should be in a json array, even if it has length 1.}
\item{collapse}{a string that is used as the separator when combining the individual lines of the generated JSON content}
}
\examples{jsoncars <- opencpu.encode(cars);
cat(jsoncars);
identical(opencpu.decode(jsoncars), cars);}

