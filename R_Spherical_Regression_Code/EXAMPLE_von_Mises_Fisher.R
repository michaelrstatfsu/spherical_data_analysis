# Demo Plotting Tools for Spherical Data Analysis
setwd('/home/michael/Documents/github_repositories/spherical_data_analysis/R_Spherical_Regression_Code/')
# Requires rgl library
library("rgl") # for plotting 3d graphics
source('plottingfunctions.R') # functions for plotting spherical regression models on $\mathbb{s}^2$
source('sd_functions.R') # functions for analysis on $\mathbb{s}^{d-1}$
source('MATLAB_like.R') # R functions which mimic Matlab functions
source('sd_von_Mises_Fisher.R') # functions for simulating and testing the von Mises-Fisher distribution


#Generate data from a von Mises Fisher Distribution
n=100 # number of observations
m=3; # dimension $\mathbb{S}^{m-1}$
kappa=100 # concentration parameter
mu=matrix(c(1,1,-1));mu=mu/sqrt(sum(mu*mu)) # Mean dieation
z=rvonMisesFisher(n,m, kappa, mu)  # generate the data


rgl.close()#Closes the current dev
open3d(windowRect=c(0,0,800,600)) # open a 600x800 window
bg3d("black")# Set background color
MESH(mksphere(30)) # plot a 30x30 meshgrid of a unit sphere
PLOT(z,col='yellow') # add points to the sphere
VIEW(mu) # this will move the view to center around the unit vector mu
#lines3d(c(0,2),c(0,0),c(0,0),col='red') #x-axis
#lines3d(c(0,0),c(0,2),c(0,0),col='white') #y-xis
#lines3d(c(0,0),c(0,0),c(0,2),col='blue') #z-axis
rgl.bringtotop();snapshot3d('example_von_mises_fisher.png')


kappa_tilde(z) # estimated kappa


png(filename = "example_von_mises_fisher_hist_plot.png") # saves the next R plot to png file
vMF_gof(z)  # runs a goodness of fit test and 
dev.off() # this closes the file (otherwise the file will remain open and other programs will not be able to open the file)
# If concentation is large, the Histogram plot should follow a chisquare distribution with df=2
# likelihood ratio test H0:von Mises-Fisher HA:Fisher-Bingham

