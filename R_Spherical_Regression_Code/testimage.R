# Demo Plotting Tools for Spherical Data Analysis
setwd('/home/michael/Documents/github_repositories/spherical_data_analysis/R_Spherical_Regression_Code/')
# Requires rgl library
library("rgl")
source('plottingfunctions.R')
# Set IMAGE file paths
image01='earth_800.png'
image02='earth_1600.png'
cloud01='clouds_8_28_12.png'

#Example 01
bg3d("white")# Set background color
GLOBE(image02);# Plot the globe using a texturemap
#CLOUD(cloud01);# add cloud layer
p=runif(3,-1,1);p=p/sqrt(sum(p*p)); # Generate a random point on the sphere
POINTS3(p[1],p[2],p[3],col='yellow',s=3);#plot the point on the sphere using a 3d marker (more memory used)
POINTS2(p[1],p[2],p[3],col='red',s=20);#plot the point on the sphere using a 2d marker (less memory used)
VIEW(p,scale=2);#change to view oriented to the randomly generated point
rgl.bringtotop();snapshot3d('testimage01.png')

#Example 02
bg3d("black")# Set background color
GLOBE(image02);# Plot the globe using a texturemap
CLOUD(cloud01);# add cloud layer
POINTS3(p[1],p[2],p[3],col='yellow',s=3);#plot the point on the sphere using a 3d marker (more memory used)
POINTS2(p[1],p[2],p[3],col='red',s=20);#plot the point on the sphere using a 2d marker (less memory used)
VIEW(p,scale=2);#change to view oriented to the randomly generated point
rgl.bringtotop();snapshot3d('testimage02.png')

#Example 03
n=1000;p=matrix(runif(3*n,0,1),nrow=n,ncol=3);norms=sqrt(rowSums(p*p));p=p/norms; # Generate a random point on the sphere
mu=colSums(p);mu=mu/sqrt(sum(mu*mu))
rgl.close()#Closes the current dev
open3d(windowRect=c(0,0,500,500)) # open a 500x500 window
Gam_id=mksphere(30) #creates a 30x30x3 array which represents a sphere
MESH(Gam_id)#Plot the mesh
POINTS3(p[,1],p[,2],p[,3],col='red');#plot the point on the sphere using a 2d marker (less memory used)
VIEW(mu,scale=2);#change to view oriented to the randomly generated point
rgl.bringtotop();snapshot3d('testimage03.png')

#Example 04
n=10000;p=matrix(runif(3*n,0,1),nrow=n,ncol=3);norms=sqrt(rowSums(p*p));p=p/norms; # Generate a random point on the sphere
mu=colSums(p);mu=mu/sqrt(sum(mu*mu))
Gam_id=mksphere(60) #creates a 60x60x3 array which represents a sphere
rgl.close()#Closes the current dev
open3d(windowRect=c(0,0,600,800)) # open a 600x800 window
MESH(Gam_id)#Plot the mesh
POINTS2(p[,1],p[,2],p[,3],col='red');#plot the point on the sphere using a 2d marker (less memory used)
VIEW(mu,scale=2);#change to view oriented to the randomly generated point
rgl.bringtotop();snapshot3d('testimage04.png')

#Example 05 a projective Linear Transformation
M=60;
Gam_id<-mksphere(M) #creates a MxMx3 array which represents a sphere
gam_id<-t(matrix(Gam_id,ncol=3))
#A0<-diag(3)+matrix(rnorm(9,0,.3),ncol=3)
A0=rotMat(matrix(c(0,0,1)),matrix(c(1,1,1)))
gam_A0<-A0%*%gam_id;norms=sqrt(colSums(gam_A0*gam_A0));gam_A0=t(t(gam_A0)/norms);
Gam_A0<-array(t(gam_A0), dim = c(M,M,3))# Distorted grid
#rgl.close()#Closes the current dev
#open3d(windowRect=c(0,0,800,600)) # open a 600x800 window
#bg3d("black")# Set background color
MESH(Gam_A0)#Plot the distorted grid
VIEW(scale=1.5);#change to view oriented to the randomly generated point
rgl.bringtotop();snapshot3d('testimage05.png')



#
a=matrix(c(0,0,1));a=a/sqrt(sum(a^2))
b=matrix(c(0,0,1))
A0=rotMat(b,a)
gam_A0<-A0%*%gam_id
Gam_A0<-array(t(gam_A0), dim = c(M,M,3))# Distorted grid

rgl.close()#Closes the current dev
open3d(windowRect=c(0,0,800,600)) # open a 600x800 window
bg3d("black")# Set background color
MESH(Gam_A0,image01)
#WIRE(1.01*Gam_A0,'white')
lines3d(c(0,2),c(0,0),c(0,0),col='red')
lines3d(c(0,0),c(0,2),c(0,0),col='white')
lines3d(c(0,0),c(0,0),c(0,2),col='blue')


PLOT(p)
WIRE(1.01*Gam_id,'white')
VIEW(p)


