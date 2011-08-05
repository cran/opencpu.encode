\name{opencpu.decode}
\alias{opencpu.decode}
\title{Decode a JSON string to an R object...}
\usage{opencpu.decode(jsonstring, safe=TRUE)
}
\description{Decode a JSON string to an R object}
\details{A standard json encoding has been defined to store S3 data objects
in a way that they will can be (almost) completely restored.}
\value{An R object}
\note{All encoded objects should pass the validation at www.jsonlint.org}
\references{\url{http://www.jsonlint.org}}
\author{Jeroen Ooms \email{jeroen.ooms@stat.ucla.edu}}
\arguments{\item{jsonstring}{A character string containing the JSON data.}
\item{safe}{Safe decoding. When FALSE, code will be evaluated during decoding.}
}

