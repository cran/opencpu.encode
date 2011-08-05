\name{as.scalar}
\alias{as.scalar}
\title{Add class 'scalar' to an object...}
\usage{as.scalar(obj)
}
\description{Add class 'scalar' to an object}
\details{Function simply adds class 'scalar' to the object and returns it.
Objects of class 'scalar' of length 1 will be encoded as a json primitive instead of an array.}
\value{The same R object}
\author{Jeroen Ooms \email{jeroen.ooms@stat.ucla.edu}}
\arguments{\item{obj}{the R object to classified as scalar.}
}
\examples{asJSON(list(foo=123));
asJSON(list(foo=as.scalar(123)));}

