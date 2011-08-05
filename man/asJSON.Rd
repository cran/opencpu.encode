\name{asJSON}
\alias{asJSON}
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
\title{Serialize an R object to JSON.}
\arguments{
  \item{x}{the object to be serialized}

  \item{container}{if the object always should be in a json
  array, even if it has length 1.}

  \item{collapse}{a string that is used as the separator
  when combining the individual lines of the generated JSON
  content}
}
\value{
  A valid JSON string
}
\description{
  This is a slightly modified version of the asJSON
  function in RJSONIO. This function is mostly for internal
  use. Please use opencpu.encode instead.
}
\note{
  All encoded objects should pass the validation at
  www.jsonlint.org
}
\examples{
jsoncars <- opencpu.encode(cars);
cat(jsoncars);
identical(opencpu.decode(jsoncars), cars);
}
\author{
  Jeroen Ooms \email{jeroen.ooms@stat.ucla.edu}
}
\references{
  \url{http://www.jsonlint.org}
}

