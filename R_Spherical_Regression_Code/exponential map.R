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

open3d(windowRect=c(0,0,800,600)) # open a 600x800 window
bg3d("black")# Set background color
M=30
GAMMA_ID=mksphere(M)
MESH(GAMMA_ID)
VIEW(matrix(rowMeans(X)))

p=matrix(c(0,0,1,0,0,1),c(3,2))
v=matrix(c(0,1,0,.5,0,0),c(3,2))
z=EXP_sd(p,v)
lines3d(c(p[1,],p[1,]+v[1,]),c(p[2,],p[2,]+v[2,]),c(p[3,],p[3,]+v[3,]),col='red')
PLOT(p)
PLOT(z)
