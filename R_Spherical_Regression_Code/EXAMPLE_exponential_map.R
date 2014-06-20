# Demo Plotting Tools for Spherical Data Analysis
setwd('/home/michael/Documents/github_repositories/spherical_data_analysis/R_Spherical_Regression_Code/')
# Requires rgl library
library("rgl")
source('plottingfunctions.R')
source('sd_functions.R')
source('MATLAB_like.R')

image01='earth_800.png'
image02='earth_1600.png'
cloud01='clouds_8_28_12.png'


p=matrix(c(0,0,1,0,0,1),c(3,2))
v=matrix(c(0,1,0,.5,0,0),c(3,2))
z=EXP_sd(p,v)

open3d(windowRect=c(0,0,800,600)) # open a 600x800 window
bg3d("black")# Set background color
M=30;GAMMA_ID=mksphere(M) #make a MxMx3 meshgrid for a sphere
MESH(GAMMA_ID) #Plot Meshgrid
vfield_sphere(p,v,w=5)
geodesic_sphere(p,v,w=5)
PLOT(p)
PLOT(z,col='blue')
VIEW(matrix(rowMeans(z)))

u=INVEXP_sd(z,p)

open3d(windowRect=c(0,0,800,600)) # open a 600x800 window
bg3d("black")# Set background color
M=30
GAMMA_ID=mksphere(M)
MESH(GAMMA_ID)
vfield_sphere(z,u)
geodesic_sphere(z,u)
PLOT(p,col='blue')
PLOT(z,col='red')
VIEW(matrix(rowMeans(z)))

n=10;p=matrix(runif(3*n,0,1),nrow=3,ncol=n);norms=sqrt(colSums(p*p));p=t(t(p)/norms); # Generate a random point on the sphere
z=matrix(runif(3*n,0,1),nrow=3,ncol=n);norms=sqrt(colSums(z*z));z=t(t(z)/norms); # Generate a random point on the sphere
u=INVEXP_sd(p,z)

open3d(windowRect=c(0,0,800,600)) # open a 600x800 window
bg3d("black")# Set background color
M=30
GAMMA_ID=mksphere(M)
MESH(GAMMA_ID)
vfield_sphere(p,u)
geodesic_sphere(p,u)
PLOT(p,col='blue')
PLOT(z,col='red')
VIEW(matrix(rowMeans(z)))
