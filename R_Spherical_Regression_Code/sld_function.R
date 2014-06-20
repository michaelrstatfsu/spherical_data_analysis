library('Matrix')
Basis_T_SLd<-function(A=diag(3)) {
  dA=dim(A);d=dA[1];
  #  Construct orthonormal basis for $T_I(SL(d))$
  n=1;
  E= array(0,c(d,d,d^2-1));
  for (i in 1:d) {
    for (j in setdiff((1:d),i)) {
      E[i,j,n]= 1;
      n=n+1;
    }
    if (n<=(d^2-1)) {0
      E[i,i,n]= 1;
      E[d,d,n]= -1;
      n=n+1;
    }
  }
  EA=E
  if (sum(A== diag(d))==d*d){    
    for (j in 1:(d^2-1)) {
      EA[,,j]=A%*%E[,,j];
    }
    # Orthonomralize using Gram Schmidt
    u=EA;
    v=array(0,c(d,d,d^2-1))
    e=array(0,c(d,d,d^2-1))
    v[,,1]=u[,,1];
    e[,,1]=v[,,1]/sqrt(sum(diag(v[,,1]%*%t(v[,,1]))))
    for (i in 2:(d^2-1)) {
      v[,,i]=u[,,i]
      for (j in 1:(i-1)) {
        v[,,i]=v[,,i]- v[,,j]*sum(diag(u[,,i]%*%t(v[,,j])))/sum(diag(v[,,j]%*%t(v[,,j])))
      }
      e[,,i]=v[,,i]/sqrt(sum(diag(v[,,i]%*%t(v[,,i]))));
    }
  }
  return(EA)
}

sl_generator<-function(d=3) {
  E= Basis_T_SLd(diag(d))
  v=rnorm(d^2-1,0,1/3)
  A=matrix(0,d,d)
  for (i in 1:(d^2-1)) {
    A=A+v[i]*E[,,i]
  }
  return(matrix(expm(A),d,d))
}