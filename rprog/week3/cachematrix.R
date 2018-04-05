# Return a list of functions to handle cached object
makeCacheMatrix <- function(x = matrix()) {

    # store the inverse if it has been already computed
    inverse <- NULL

    # set a new value for the matrix
    # and NULL for the its inverse
    setvalue <- function(mat) {
        x <<- mat
        inverse <<- NULL
    }

    # getter functions
    get <- function() x
    getinv <- function() inverse

    # setter function (store into cache)
    setinv <- function(inv) inverse <<- inv

    # return list of helper functions
    list(setvalue = setvalue,
         get = get,
         setinv = setinv,
         getinv = getinv)
}


# Cache-optimizate computation of inverse matrix
cacheSolve <- function(x, ...) {

    # Retrieve cached object
    inv <- x$getinv()

    # If the inverse is in cache return it
    if (!is.null(inv)) {
        message("Returning cached inverse")
        return(inv)
    }

    # Otherwise compute it
    message("Computing inverse...")
    inverse <- solve(x$get()) # assume is invertible

    # Set it into cache
    x$setinv(inverse)

    # and return it
    inverse
}
