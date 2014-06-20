# Demo Plotting Tools for Spherical Data Analysis
setwd('/home/michael/Documents/github_repositories/spherical_data_analysis/R_Spherical_Regression_Code/')
source('plottingfunctions.R')
source('sd_functions.R')
source('MATLAB_like.R')

image01='earth_800.png'
image02='earth_1600.png'
cloud01='clouds_8_28_12.png'

# Requires rgl, png, and library(R.matlab) libraries
library("rgl")
library("png")
library(R.matlab)





# IMPORT DATA FROM MATLAB
#data<-readMat("midatlantic_cv_fitted_3_light.mat")
data<-readMat("midatlantic_cv_2.011_10_60_0.0044444_light.mat")
#Convert 3X60*60 arrays to 60X60X3 arrays
gamma_id=data$grid;gamma=data$grid2
Gamma_id=array(t(gamma_id), dim = c(60,60,3))# identity warping
Gamma=array(t(gamma), dim = c(60,60,3))# Estimated warping
#import data points
data2<-readMat("midatlantic.mat")
X=data2$X # Response variable
Y=data2$Y # Predictor variable



p=c(1,1,1)/sqrt(3)

rgl.close()#Closes the current dev
open3d(windowRect=c(0,0,800,600)) # open a 600x800 window
bg3d("black")# Set background color
#lines3d(c(0,2),c(0,0),c(0,0),col='red') #x-axis
#lines3d(c(0,0),c(0,2),c(0,0),col='white') #y-xis
#lines3d(c(0,0),c(0,0),c(0,2),col='blue') #z-axis
MESH(Gamma,image02)

PLOT(Y,col='red')
VIEW(matrix(rowMeans(X)))


