OPENCPU R DATASTRUCTURE ENCODING STANDARD
=========================================

version 0.1 
July 2011

(1) PURPOSE
-----------

The purpose of this definition is to specify a method of encoding R datastructures, in way that is human readable and convenient for other software to interpret and translate into something that 
makes sense in the domain of the application. Some possible applications are databases, rpc interfaces and 3rd party software that is interacting with R. The definition is designed
mostly for R, but should not exclude possible other statistical datastructures that are not (yet) represented by R.

(2) ABOUT JSON
--------------

This standard is defined as a subset of the JSON language, as defined on www.json.org, and validated by www.jsonlint.org. The main motivations for choosing JSON are that it is light weight, has little overhead, and can be parsed efficiently, which is relevant in the context of statistical data. Furthermore the standard is widely adopted and reliable parsers are available for many programming languages. 

Some relevant properties are that JSON has a very limited set of primitive values, namely strings, numbers, booleans and null. For numbers, E-notation (e.g. 6.02e+23) is allowed, but NA, NaN, and Inf are not. Also, in an JSON array, elements are allowed to be of a different type. For example: [ 3.14, "NA", "Inf" ] is valid JSON as it contains numbers and strings. Also, within a JSON object all elements should have a unique name. 

(3) THE SCHEMA
--------------

Every R object is encoded as a json object (an unordered set of name/value pairs enclosed in curly braces), and contains 3 elements: "encoding.mode", "value", and "attributes", defined as follows:

Encoding.mode:
This defines a specific encoding scheme as defined in section (5). Encoding modes have currently been defined for at least all basic R storage.modes, and some additional ones for special R classes. The list of encoding schemes can be extended in future versions, but should always be backwards compatible. 

Value:
The data of the object, encoded according to the specified Encoding mode.

Attributes:
A json object with named attributes. The names of the attributes map directly to the names of the object. As every attribute can again be any R object, this works recursively. 

(4) MISSING VALUES, INFINITE VALUES AND NULL
--------------------------------------------

R defines several domain specific primitive types that have no natural representation in JSON. These are NA (Not Availabe), NaN (Not a Number), Inf and -Inf (infinty and -infinity) and NULL (nothing). When appearing within a vector, null always represents NA. E.g. ["foo", null, "bar"] should be interpreted as c("foo", NA, "bar").

For vectors with storage mode "double", there is an additional option to quote the non-numeric values as a character string, i.e. [3.14, "NA", "NaN", 5.67, "-Inf"]. Note that within a numeric vector, both "NA" and null are valid representations of NA. 

The NULL value in R will be encoded as an empty object: {}, and not as json null to emphasize that null means NA. 

(5) IMPLEMENTATION
------------------

A first testing implementation for R is available on CRAN in the form of an R package called opencpu.encode. 

(6) ENCODING MODES
------------------

* Logical -- A JSON array with true (TRUE), false (FALSE) and null (NA)

Example: `c(TRUE,TRUE,FALSE,NA,NA,TRUE)` 

	{
	    "encode.mode": "logical",
	    "attributes": {},
	    "value": [
	        true,
	        true,
	        false,
	        null,
	        null,
	        true
	    ]
	}


* Integer -- A JSON array with integers and null

Example: `as.integer(c(1,2,NA,4))`

	{
	    "encode.mode": "integer",
	    "attributes": {},
	    "value": [
	        1,
	        2,
	        null,
	        4
	    ]
	}


* Double: A JSON array with valid numbers, or "NA", "NaN", "Inf", "-Inf" or null

Example: `c(pi, NA, NaN, 8, Inf, 10, -Inf, 10^100, 5.53*10^-83)`

	{
	    "encode.mode": "double",
	    "attributes": {},
	    "value": [
	        3.1416,
	        "NA",
	        "NaN",
	        8,
	        "Inf",
	        10,
	        "-Inf",
	        1e+100,
	        4.53e-83
	    ]
	}


* Character -- A JSON array with double quoted character strings or null
 
Example: `c("foo", NA", "bar", "")` 

	{
	    "encode.mode": "character",
	    "attributes": {},
	    "value": [
	        "foo",
	        null,
	        "bar",
	        ""
	    ]
	}


* List -- A JSON array with the elements of the list. Every element is again (recursively) encoded according to the same standard.
Note that the names of the list are not part of the value but are an attribute. This allows for encoding of unnamed lists, or lists with duplicate names.

Example: `cars[1:5,]` 

	{
	    "encode.mode": "list",
	    "attributes": {
	        "names": {
	            "encode.mode": "character",
	            "attributes": {},
	            "value": [ "speed", "dist" ]
	        },
	        "row.names": {
	            "encode.mode": "integer",
	            "attributes": {},
	            "value": [ 1, 2, 3, 4, 5 ]
	        },
	        "class": {
	            "encode.mode": "character",
	            "attributes": {},
	            "value": [ "data.frame" ]
	        }
	    },
	    "value": [
	        {
	            "encode.mode": "double",
	            "attributes": {},
	            "value": [ 4, 4, 7, 7, 8 ]
	        },
	        {
	            "encode.mode": "double",
	            "attributes": {},
	            "value": [ 2, 10, 4, 22, 16 ]
	        }
	    ]
	}

* Language -- A deparsed character string.

Example: `y ~ x1 + x2`

	{
	    "encode.mode": "language",
	    "attributes": {
	        "class": {
	            "encode.mode": "character",
	            "attributes": {},
	            "value": [
	                "formula"
	            ]
	        },
	        ".Environment": {
	            "encode.mode": "environment",
	            "attributes": {},
	            "value": {}
	        }
	    },
	    "value": [
	        "y ~ x1 + x2"
	    ]
	}

* Function -- A deparsed function as an array of character strings.

Example: `graphics::plot`

	{
	    "encode.mode": "function",
	    "attributes": {},
	    "value": [
	        "function (x, y, ...) ",
	        "{",
	        "    if (is.function(x) && is.null(attr(x, \"class\"))) {",
	        "        if (missing(y)) ",
	        "            y <- NULL",
	        "        hasylab <- function(...) !all(is.na(pmatch(names(list(...)), ",
	        "            \"ylab\")))",
	        "        if (hasylab(...)) ",
	        "            plot.function(x, y, ...)",
	        "        else plot.function(x, y, ylab = paste(deparse(substitute(x)), ",
	        "            \"(x)\"), ...)",
	        "    }",
	        "    else UseMethod(\"plot\")",
	        "}"
	    ]
	}

* Date -- ISO 8601 Date format.

Example: `as.Date(Sys.time())+1:3`

	{
	    "encode.mode": "Date",
	    "attributes": {
	        "class": {
	            "encode.mode": "character",
	            "attributes": {},
	            "value": [
	                "Date"
	            ]
	        }
	    },
	    "value": [
	        "2011-07-27",
	        "2011-07-28",
	        "2011-07-29"
	    ]
	}

* POSIXct -- ISO 8601 Datetime

Example: `Sys.time() + 1:3`:

	{
	    "encode.mode": "POSIXct",
	    "attributes": {
	        "class": {
	            "encode.mode": "character",
	            "attributes": {},
	            "value": [
	                "POSIXct",
	                "POSIXt"
	            ]
	        }
	    },
	    "value": [
	        "2011-07-26 13:06:40",
	        "2011-07-26 13:06:41",
	        "2011-07-26 13:06:42"
	    ]
	}

* Raw -- A 'raw' vector encoded in base64

Example: `charToRaw("Standards are cool!")`
  
	{
	    "encode.mode": "raw",
	    "attributes": {},
	    "value": [
	        "U3RhbmRhcmRzIGFyZSBjb29sIQ=="
	    ]
	}
	
* Complex -- A json object with a real and a complex vector

Example: `complex(real=rnorm(3), im=rnorm(3))`

	{
	    "encode.mode": "complex",
	    "attributes": {},
	    "value": {
	        "real": [
	            1.3725,
	            -1.6617,
	            -0.84974
	        ],
	        "imaginary": [
	            -1.6089,
	            0.2044,
	            0.66717
	        ]
	    }
	}
	
More to come...