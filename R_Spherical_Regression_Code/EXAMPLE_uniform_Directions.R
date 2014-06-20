# Demo Plotting Tools for Spherical Data Analysis
setwd('/home/michael/Documents/github_repositories/spherical_data_analysis/R_Spherical_Regression_Code/')
# Requires rgl library
library("rgl")
source('plottingfunctions.r')
source('sd_functions.r')

# Generate points Uniformly on the sphere
n=1000
p=UNIFORMdirections(3,n)

rgl.close()#Closes the current dev
open3d(windowRect=c(0,0,800,600)) # open a 600x800 window
bg3d("black")# Set background color
MESH(mksphere(30))
PLOT(p,col='yellow')

