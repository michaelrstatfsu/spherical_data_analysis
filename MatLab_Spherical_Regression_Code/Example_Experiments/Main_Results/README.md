PARAMETRIC AND NONPARAMETRIC SPHERICAL REGRESSION WITH DIFFEOMORPHISMS

By Michael Rosenthal

Professor Co-Directing Dissertation
    Anuj Srivastava
    Wei Wu
University Representative
    Eric Klassen
Committee Member
    Debdeep Pati

In this folder, these are some examples of analysis performed on different data sets. For details on this data, see my dissertation.

The following function creates a summary table, computes residual diagnostics statistics, and creates plots for the data.
MAIN_Spherical_Regression_Analysis

The diffeomorphic regression models have been run in advanced because they take time to tune and fit. The main model fitting functions are:
* PARAMETRIC MODELS
    * PLT
    * RRR
    * LLR
* NONPARAMETRIC MEODELS
    * [Grid2,E,Xtilde,path] = NPSR(X,Y,lambda,l,NN)
    
The NPSR function currently only applies to the case where M=3, i.e. for data on $\mathbb{S}^2$. All the other functions work for arbitrary 
    * [m] = LocalLR(X,Y,Xnew,kappa)



They all take the arguments (X,Y) where the predictor X and response Y are MxN matrices where the columns denote corresponding observations of spherical data on the $\mathbb{S}^{M-1}$ dimensional hypersphere.

