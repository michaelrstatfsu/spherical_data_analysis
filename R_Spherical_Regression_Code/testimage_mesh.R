# Demo Plotting Tools for Spherical Data Analysis
setwd('/home/michael/Documents/github_repositories/spherical_data_analysis/R_Spherical_Regression_Code/')
# Requires rgl library
library("rgl")
source('plottingfunctions.r')
source('sd_functions.r')
image01='earth_800.png'
image02='earth_1600.png'
cloud01='clouds_8_28_12.png'




library(R.matlab)
#data<-readMat("midatlantic_cv_fitted_3_light.mat")
data<-readMat("midatlantic_cv_2.011_10_60_0.0044444_light.mat")
data2<-readMat("midatlantic.mat")
X=data2$X
Y=data2$Y

gamma_id=data$grid
gamma=data$grid2
d=dim(gamma)
M=sqrt(d[2])
Gamma=array(t(gamma), dim = c(M,M,3))# Distorted grid

p=c(1,1,1)/sqrt(3)

rgl.close()#Closes the current dev
open3d(windowRect=c(0,0,800,600)) # open a 600x800 window
bg3d("black")# Set background color
#lines3d(c(0,2),c(0,0),c(0,0),col='red') #x-axis
#lines3d(c(0,0),c(0,2),c(0,0),col='white') #y-xis
#lines3d(c(0,0),c(0,0),c(0,2),col='blue') #z-axis
MESH(Gamma,image02)

PLOT(X,col='yellow')
PLOT(Y,col='red')
VIEW(matrix(rowMeans(X)))


open3d(windowRect=c(0,0,800,600)) # open a 600x800 window
bg3d("white")# Set background color
M=10
GAMMA_ID=mksphere(M)
MESH(GAMMA_ID)
VIEW(matrix(rowMeans(X)))
