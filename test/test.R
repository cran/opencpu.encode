# TODO: Add comment
# 
# Author: jeroen
###############################################################################


library(opencpu.encode);

#simple test
identical(opencpu.decode(opencpu.encode(cars)), cars)

#Common datastructures
#note that because of rounding, randomness and environments, 'identical' is actually too strict
set.seed('123')
myobject <- list(
		mynull = NULL,
		mycomplex = lapply(eigen(matrix(-rnorm(9),3)), round, 3),
		mymatrix = round(matrix(rnorm(9), 3),3),
		myint = as.integer(c(1,2,3)),
		myfactor = factor(c("XL", "XS", "M"), levels=c("XS", "S", "M", "L", "XL"), ordered=TRUE),
		mydf = cars,
		mylist = list(foo="bar", 123, NA, NULL, list("test")),
		mylogical = c(T,F,NA,T),
		mychar = c("foo", NA, "bar"),
		somemissings = c(1,2,NA,NaN,5, Inf, 7 -Inf, 9, NA),
		myrawvec = charToRaw("This is a test")
);
identical(opencpu.decode(opencpu.encode(myobject)), myobject)

#language objects
ll <- list(a = expression(x^2 - 2*x + 1), b = as.name("Jim"),
		c = as.expression(exp(1)), d = call("lm", x~y), e=lm);
sapply(ll, storage.mode);
opencpu.decode(opencpu.encode(ll))

#this should pass the validators
cat(opencpu.encode(ll));

#Dates and time
now <- Sys.time();
today <- as.Date(now);
gmt <- as.POSIXlt(now);

## dates and times
cat(opencpu.encode(now));
cat(opencpu.encode(today));
cat(opencpu.encode(gmt));

# datetime_encode
cat(opencpu.encode(today, datetime=F));

#something advanced
myglm <- glm(Sepal.Length ~ ., data=iris);
cat(opencpu.encode(myglm));
