# Author: A. Johan
# Date: 14 Jun 2020
#
# ****************************************************************************
#
# This file contains functions to create a new matrix object and store in 
# cache. It also contains functions to calculate the Inverse Square of a matrix
# and store the value in the cached object. In subsequent calls to calculate
# the Inverse square value, it will be returned from the cache if the value
# of the matrix has not changed
#
# ****************************************************************************

# makeCacheMatrix
# This function creates a Matrix object that returns 4 functions:
# - set(), get(), getinverse(), setinverse()
#
# set()        - Sets the value of the matrix we want to cache
# get()        - Gets the current value of the matrix that is stored in 
#                the cache
# setinverse() - Function to set the value Inverse square value of a matrix in
#              - the cache
# getinverse() - Returns the current value of the Inverse square matrix  
#                in the cache. Defaults to NULL
#
makeCacheMatrix <- function(x = matrix()) {

  # Variable to hold the Inverse Square Matrix
  ism <- NULL
  
  # Setter (Mutator) to set new value of x and will also reset the value of ism
  set <- function (m) {
    x <<- m
    ism <<- NULL
  }

  # Getter (Accessor) to get the value of x from outside 
  get <- function() {
    x
  }
  
  # Function to return the value of the Inverse square matrix
  getinverse <- function() {
    ism
  }
  
  # Function to calculate the inverse of a matrix
  setinverse <- function(inverse) {
    ism <<- inverse
  }
  
  # Return the methods as a list. When we do this a new object is returned
  # the the parent environment
  list(set = set, get = get, getinverse = getinverse, setinverse = setinverse)
}


# cacheSolve
# Function that returns the Inverse square value of a matrix.
# First, it tries to obtain the value from the cached of the passed object
# If the return value is NOT NULL, then it will return the cached value,
# else it will calculate the new value of the inverse square
cacheSolve <- function(x, ...) {
  
  # Get the value of the inverse square from the cache, if the value of 
  # the matrix has not changed the returned value will be *NOT NULL*
  # If the value is from cache then we use the return() function to 
  # return the inverse square value and exit cacheSolve() 
  m <- x$getinverse()
  if (!is.null(m)) {
    message("Getting value from cache")
    return(m)
  }
  
  # Get the matrix from the cache and calculate the inverse square
  thematrix <- x$get()
  i <- solve(thematrix)
  x$setinverse(i)
  i
}

