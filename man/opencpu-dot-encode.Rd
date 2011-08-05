\name{opencpu.encode}
\alias{opencpu.encode}
\title{Encode an R object to standardized JSON notation...}
\usage{opencpu.encode(obj, NA_encode=TRUE, datetime_encode=TRUE, digits=5, collapse=" ")
}
\description{Encode an R object to standardized JSON notation}
\details{A standard json encoding has been defined to store S3 data objects
in a way that they will can be (almost) completely restored.}
\value{A valid JSON string}
\note{All encoded objects should pass the validation at www.jsonlint.org}
\references{\url{http://www.jsonlint.org}}
\author{Jeroen Ooms \email{jeroen.ooms@stat.ucla.edu}}
\arguments{\item{obj}{the R object to be encoded}
\item{NA_encode}{Should NA, NaN, and Inf within a numeric vector be encoded as strings (TRUE) or as null (FALSE).}
\item{datetime_encode}{Should Dates, POSIXt classes be encoded as strings (TRUE) or as regular objects.}
\item{digits}{Number of digits to print for numeric values.}
\item{collapse}{a string that is used as the separator when combining the individual lines of the generated JSON content}
}
\examples{jsoncars <- opencpu.encode(cars);
cat(jsoncars);
identical(opencpu.decode(jsoncars), cars);

# note that because of rounding, randomness and environments, 'identical' 
# is actually too strict.
set.seed('123')
myobject <- list(
mynull = NULL,
mycomplex = lapply(eigen(matrix(-rnorm(9),3)), round, 3),
mymatrix = round(matrix(rnorm(9), 3),3),
myint = as.integer(c(1,2,3)),
mydf = cars,
mylist = list(foo="bar", 123, NA, NULL, list("test")),
mylogical = c(TRUE,FALSE,NA),
mychar = c("foo", NA, "bar"),
somemissings = c(1,2,NA,NaN,5, Inf, 7 -Inf, 9, NA),
myrawvec = charToRaw("This is a test")
);
stopifnot(identical(opencpu.decode(opencpu.encode(myobject)), myobject));}

