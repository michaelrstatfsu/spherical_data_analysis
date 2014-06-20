repmat = function(X,m,n){
  ##R equivalent of repmat (matlab)
  mx = dim(X)[1]
  nx = dim(X)[2]
  matrix(t(matrix(X,mx,nx*n)),mx*m,nx*n,byrow=T)
}

meshgrid <- function(a,b) {
  # Similiar to Matlab's meshgrid function
  list(
    x=outer(b*0,a,FUN="+"),
    y=outer(b,a*0,FUN="+")
  )
} 
