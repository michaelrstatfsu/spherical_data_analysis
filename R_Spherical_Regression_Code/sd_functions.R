mksphere<-function(M=60){
  # creates a MxMx3 array which represents a meshgrid sphere for $\mathbb{S}^2$.
  eps=10^(-10)
  r=1  
  n=M-1
  theta = pi*(.01:(n+1-.01))/(n+.02)
  phi = 2*pi*(0:n/n)
  Theta = repmat(t(matrix(theta)),n+1,1)
  Phi = repmat(matrix(phi),1,n+1)
  GRID=s2c(Theta,Phi);  
  grid=array(0,dim=c(M,M,3))
  grid[,,1]=array(GRID[[1]])
  grid[,,2]=array(GRID[[2]])
  grid[,,3]=array(GRID[[3]])
  return(grid)
}


s2c<-function(Theta,Phi,r=1){
  # Converts spherical to cartesian coordinates
  x=r*sin(Theta)*cos(Phi);
  y=r*sin(Theta)*sin(Phi);
  z=r*cos(Theta);  
  return(list(x,y,z))
}

c2s<-function(X,Y,Z){
  # Converts cartesian to spherical coordinates
  phi=Re(atan(Y/X));theta=Re(acos(Z));  
  Xp=(X>0);Xn=(X<0);Xnn=(X>=0);Xnp=(X<=0);Yp=(Y>0);Yn=(Y<0);Ynn=(Y>=0);Ynp=(Y<=0);
  phi=phi+Xp*Ynn*(-2)*(pi/2)+Xnn*Yn*(2)*(pi/2)+pi;
  phi[phi=='NaN']=0;
  return(list(theta,phi))
}

EXP_sd=function(p,v) {

dv=dim(v);dp=dim(p)
if (dp[2]==1){p=p%*%matrix(1,1,dv[2])}
theta=matrix(sqrt(colSums(v^2)),1,dv[2]);
y=(matrix(1,dv[1],1)%*%cos(theta))*p+(matrix(1,dv[1],1)%*%sin(theta))*v/(matrix(1,dv[1],1)%*%theta);
y[,(theta<10^(-20))]=p[,(theta<10^(-20))];
return(y)
}

INVEXP_sd<-function(p,z) {
  dz=dim(z)
  dp=dim(p)
  u=matrix(0,dz[1],dz[2])
  Index=1:dz[2]
  theta=matrix(0,sum(colSums((z-p)^2)>10^(-20)),1)
  
  if (dp[2]==1){
    for (n in Index[colSums((z-p)^2)>10^(-20)]) {
      theta(n)=acos(t(z[,n])*p)
      u[,n]= (theta[n]/sin(theta[n]))%*%(z[,n]-cos(theta[n])*p);
    }}
  
  if (dp[2]!=1){
    for (n in Index[colSums((z-p)^2)>10^(-20)]) {
      theta[n]=acos(t(matrix(z[,n]))%*%matrix(p[,n]))
      u[,n]= (theta[n]/sin(theta[n]))*(matrix(z[,n])-cos(theta[n])*matrix(p[,n]));
    }}
  return(u)
}

rotMat<-function(b,a,alpha=NaN){
  #ROTMAT returns a rotation matrix that rotates unit vector b to a  
  #   rot = rotMat(b,a) returns a d x d rotation matrix that rotate
  #   unit vector b to a
  #   rot = rotMat(b,a,alpha) returns a d x d rotation matrix that rotate
  #   unit vector b towards a by alpha (in radian)
  s=dim(b);
  d = max(s);
  b= matrix(b/sqrt(sum(b^2)))
  a= matrix(a/sqrt(sum(a^2)))
  
  if (s[1]<=s[2]) {b = t(b);a = t(a)}
  if (is.nan(alpha)) {
  alpha = acos(t(a)%*%b)}
  abs(t(a)%*%b - 1) < 1e-15
  if (abs(t(a)%*%b - 1) < 1e-15) {return(diag(d))}
  if (abs(t(a)%*%b + 1)< 1e-15) {return(-diag(d))} 
  if ((abs(t(a)%*%b + 1)> 1e-15)&(abs(t(a)%*%b - 1) > 1e-15)){
    c = b - a %*% (t(a)%*%b)
    c = c /sqrt(sum(c^2))
    A = a%*%t(c) - c%*%t(a)
    rotMat = diag(d) + c(sin(alpha))*A + c(cos(alpha) - 1)*(a%*%t(a) +c%*%t(c))
    return(rotMat)
  }  
}

# Project rd to sd
project_rd_sd <- function(r) {
dr=dim(r);
z=matrix(1,dr[1]+1,dr[2])
z[1:dr[1],]=r;
z=z/(matrix(1,dr[1]+1,1)%*%sqrt(colSums(z^2)));
return(z)
}
# Project sd to rd
project_sd_rd <- function(z) {
  dz=dim(z);
  r=z[1:(dz[1]-1),]/(matrix(1,dz[1]-1,1)%*%z[dz[1],]);
  return(r)
}