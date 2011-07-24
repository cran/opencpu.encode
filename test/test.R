# TODO: Add comment
# 
# Author: jeroen
###############################################################################


# TODO: Add comment
# 
# Author: jeroen
###############################################################################


library(rweb.encode);

#simple test
identical(rweb.decode(rweb.encode(cars)), cars)

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
identical(rweb.decode(rweb.encode(myobject)), myobject)

#language objects
ll <- list(a = expression(x^2 - 2*x + 1), b = as.name("Jim"),
		c = as.expression(exp(1)), d = call("lm", x~y), e=lm);
sapply(ll, storage.mode);
rweb.decode(rweb.encode(ll))

#Dates and time
now <- Sys.time();
today <- as.Date(now);
gmt <- as.POSIXlt(now);

## dates and times
cat(rweb.encode(now));
cat(rweb.encode(today));
cat(rweb.encode(gmt));

# datetime_encode
cat(rweb.encode(today, datetime=F));

#something advanced
myglm <- glm(Sepal.Length ~ ., data=iris);
cat(rweb.encode(myglm));
