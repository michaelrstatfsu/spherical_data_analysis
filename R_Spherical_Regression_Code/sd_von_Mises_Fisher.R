UNIFORMdirections<-function(m,n){
  # generate n uniformly distributed m dim'l random directions
  # Using the logic: "directions of Normal distribution are uniform on sphere"
  V = matrix(0,m,n);
  nr = matrix(rnorm(m*n),m,n); #Normal random 
  
  for (i in 1:n){        
    repeat {
      ni=t(nr[,i])%*%nr[,i] # length of ith vector
      # exclude too small values to avoid numerical discretization
      if (ni<1e-10){
        # so repeat random generation
        nr[,i]=matrix(rnorm(m),m,1)
      } else {
        V[,i]=nr[,i]/sqrt(ni)
        break
      }  
    }
  }
  return(V)
}



rvonMisesFisher<-function(n,m, kappa, mu) {
  # RANDVONMISESFISHERM Random number generation from von Mises Fisher
  # distribution.
  # X = randvonMisesFisherm(m, n, kappa, mu) with direction parameter mu
  # (m-dimensional column unit vector)
  #
  # Sungkyu Jung, Feb 3, 2010.
  # rewritten in R by Michae Rosenthal  
  
  
  if (m < 2){
    message('Message from randvonMisesFisherm.m: dimension m must be > 2'); 
    message('Message from randvonMisesFisherm.m: Set m to be 2'); 
    m = 2;
  }
  
  if (kappa < 0){
    message('Message from randvonMisesFisherm.m: kappa must be >= 0'); 
    message('Message from randvonMisesFisherm.m: Set kappa to be 0'); 
    kappa = 0;
  }
  
  #
  # the following algorithm is following the modified Ulrich's algorithm 
  # discussed by Andrew T.A. Wood in "SIMULATION OF THE VON MISES FISHER 
  # DISTRIBUTION", COMMUN. STATIST 23(1), 1994.
  
  # step 0 : initialize
  b = (-2*kappa + sqrt(4*kappa^2 + (m-1)^2))/(m-1);
  x0 = (1-b)/(1+b);
  c = kappa*x0 + (m-1)*log(1-x0^2);
  
  # step 1 & step 2
  nnow = n;
  #cnt = 0;
  
  ntrial = max(round(nnow*1.2),nnow+10) ;
  Z =matrix(rbeta(ntrial,(m-1)/2,(m-1)/2))
  U = matrix(runif(ntrial));
  W = (1-(1+b)*Z)/(1-(1-b)*Z);
  
  indicator = kappa*W + (m-1)*log(1-x0*W) - c >= log(U);
  if (sum(indicator) >= nnow) {
    w1 = matrix(W[indicator]);
    w = matrix(c(w1[1:nnow]));
  } else {
    w = matrix(c( W[indicator]))
    nnow = nnow-sum(indicator);
    
    repeat{
      ntrial = max(round(nnow*1.2),nnow+10) ;
      Z =matrix(rbeta(ntrial,(m-1)/2,(m-1)/2))
      U = matrix(runif(ntrial));
      W = (1-(1+b)*Z)/(1-(1-b)*Z);
      
      indicator = kappa*W + (m-1)*log(1-x0*W) - c >= log(U);
      if (sum(indicator) >= nnow) {
        w1 = matrix(W[indicator]);
        w = matrix(c(w ,w1[1:nnow]));
        break;
      } else {
        
        w = matrix(c(w , W[indicator]))
        nnow = nnow-sum(indicator);
      }
    }
  }
  # step 3
  V = UNIFORMdirections(m-1,n);
  X=rbind(repmat(sqrt(1-t(w)^2),m-1,1)*V ,t(w))
  
  mu = mu / norm(mu);
  X = rotMat(matrix(c(0,0,1)),mu)%*%X;
  
  return(X)
}

sample_resultant_length<-function(z){dz=dim(z);return(sqrt(sum(rowMeans(z)^2)))}
resultant_length<-function(d,kappa){
  denom=besselI(kappa,d/2-1,1)
  if (denom != Inf) {
    A_p_kappa=besselI(kappa,d/2,1)/denom
  } else {
    A_p_kappa=1
  }
}


kappa_tilde<-function(z) {
  # Sra, S. (2011). "A short note on parameter approximation for von Mises-Fisher distributions: And a fast implementation of I s (x)". Computational Statistics 27: 177–190.
  #Computes the MSE concentration given VMF data
  #KAPPA Newton-Rapson method 
  maxitr=3; #Maximum number of iterations (algorithm usuual converges in as little as 2 iterations)
  kappatilde=matrix(0,maxitr,1);
  i=1; go=1;
  dz=dim(z);
  Rbar=sample_resultant_length(z);
  
  kappatilde[1]=(Rbar*(dz[1]-Rbar^2))/(1- Rbar^2); # Initialize Kappa
  while ((i<maxitr)&(go==1)) {
    i=i+1;
    A_p_kappa=resultant_length(dz[1],kappatilde[i-1]);
    kappa=kappatilde[i-1]; #previous kappa
    kappatilde[i]=kappa-( (A_p_kappa-Rbar)/(1-A_p_kappa^2- ((dz[1]-1)/kappa)*A_p_kappa)); #update kappa
    # go=abs(kappatilde(i-1)-kappatilde(i))>.001; # if you want a stopping criterion
  }
  return(kappatilde[i])
}

mu_tilde<-function(z) {
  #estimates the MSE mean direction given VMF data
  xbar=matrix(rowMeans(z))
  Rbar=sqrt(sum(xbar^2))
  return(xbar/Rbar)
}


center<-function(mu,y){
  dmu=dim(mu);
  arbitrary_direction= matrix(0,dmu[1],1);
  arbitrary_direction[dmu[1]]= 1;
  z=y #initialize and declare dimension of z to avoid dynamic memory allocation
  for (i in 1:dmu[2]) {
    z[,i]=rotMat(mu[,i],arbitrary_direction )%*%y[,i];
  }
}


vMF_gof<-function(z,mu=NaN,kappa=NaN){
  dz=dim(z)
  if (is.na(mu)) {
    xbar=matrix(rowMeans(z))
    mu=xbar/sqrt(sum(xbar^2))
  }
  if (is.na(kappa)) {kappa=kappa_tilde(z)}
  r=2*kappa*(1-t(z)%*%mu)
  hist(r,10,xlim=c(min(r),max(r)));
  t=seq(0,max(r),length.out=100);
  lines(t,n*dchisq(t,dz[1]-1))
  if (dz[1]==3) {
    lrt=vmf_fb_lrt3(z)
    W=lrt[1]
    pvalue=lrt[2]
    W
    pvalue
  } 
}


vmf_fb_lrt3 <- function(z) {
  dz=dim(z);
  if (dz[1]!=3) {message('p must equal 3')
  } else {
    xbar=matrix(rowMeans(z))
    Rbar=sqrt(sum(xbar^2));
    xbar0=xbar/Rbar;
    k=kappa_tilde(z);
    H=rotMat(xbar0,matrix(c(1,0,0)))
    Y=H%*%z;
    y=Y[2:dz[1],]
    l=svd(y%*%t(y)/n)
    T=(n*(k^3)*(l$d[1]-l$d[2])^2)/(4*(k-3*Rbar));
    pvalue=pchisq(T,2,lower.tail=FALSE)
    return(data.frame('Test.Statistic'=T,'p.value'=pvalue))
  }
}
