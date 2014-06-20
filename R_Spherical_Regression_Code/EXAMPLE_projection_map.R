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


#project points in R2 into S3 via Stereographic projection.
n=100;r=matrix(runif(2*n,-1,1),nrow=2,ncol=n);
R=matrix(1,3,100)
R[1:2,]=r
z=project_rd_sd(r)

open3d(windowRect=c(0,0,800,600)) # open a 600x800 window
bg3d("black")# Set background color
M=30
GAMMA_ID=mksphere(M)
MESH(GAMMA_ID)
PLOT(R)
PLOT(z,col='blue')
for (i in 1:n) {
  lines3d(c(R[1,i],z[1,i]),c(R[2,i],z[2,i]),c(R[3,i],z[3,i]),col='red')  
}

#Test inverse projection map
r2=project_sd_rd(z)
R2=matrix(1,3,100)
R2[1:2,]=r2

open3d(windowRect=c(0,0,800,600)) # open a 600x800 window
bg3d("black")# Set background color
M=30
GAMMA_ID=mksphere(M)
MESH(GAMMA_ID)
#PLOT(R)
PLOT(R2,col='blue')
sqrt(sum(diag(t(R-R2)%*%(R-R2))))
