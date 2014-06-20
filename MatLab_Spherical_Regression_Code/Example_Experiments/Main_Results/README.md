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
    * Projective Linear Transformation   
        * [A,e,Xtilde,path,A_store]= PLT_NR(X,Y,noreflect)
        * [Ahat,e,Xtilde,path]= PLT_GA(X,Y)
    * Rigid Rotation and Reflection
        * [Ahat,e,Yhat]=RRR(X,Y,noreflect)
    * Parametric Log Linear Regression
        * [Ahat,e,Yhat,Ynew]=LLR(X,Y,Xnew)
* NONPARAMETRIC MEODELS
    * Diffeomorphic Spherical Regression
        * [Grid2,E,Xtilde,path] = NPSR(X,Y,lambda,l,NN)
    * Local Linear Regression
        * [m] = LocalLR(X,Y,Xnew,kappa)



They all take the arguments (X,Y) where the predictor X and response Y are MxN matrices where the columns denote corresponding observations of spherical data on the $\mathbb{S}^{M-1}$ dimensional hypersphere.

