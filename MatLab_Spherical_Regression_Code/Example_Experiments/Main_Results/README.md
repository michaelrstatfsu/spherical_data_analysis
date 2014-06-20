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

The functions which build the model all take the same first two arguments X,Y which denote the predictor X and response Y represented as MxN matrices where the columns denote corresponding observations of spherical data on the $\mathbb{S}^{M-1}$ dimensional hypersphere.

* PARAMETRIC MODELS
    * Projective Linear Transformation   
        * **[A,e,Xtilde,path,A\_store]= PLT_NR(X,Y,noreflect)**
            * **A** is the MxM transformation matrix in SL(M) which parametrizes the projective linear transformation. The MLE for the true transformation matrix is computed using an intrinsic Newton-Raphson algorithm.
            * Xtilde is MxN matrix whose columns represent the predicted values of Y given X.
            * path is an matrix which stores the iterative path on the sphere as the Xtildes are updated in the algorithm. When M=3, this variable can be passed into the third argument of the Display_Path function to plot the algorithms convergence on the sphere.
        * [Ahat,e,Xtilde,path]= PLT\_GA(X,Y)
             * A is the MxM transformation matrix in SL(M) which parametrizes the projective linear transformation. The MLE for the true transformation matrix is computed using an intrinsic Gradient Ascent algorithm.
             * Xtilde is MxN matrix whose columns represent the predicted values of Y given X.
             * path is a matrix which stores the iterative path on the sphere as the Xtildes are updated in the algorithm. When M=3, this variable can be passed into the third argument of the Display_Path function to plot the algorithms convergence on the sphere.
    * Rigid Rotation and Reflection
        * [Ahat,e,Yhat]=RRR(X,Y,noreflect)
    * Parametric Log Linear Regression
        * [Ahat,e,Yhat,Ynew]=LLR(X,Y,Xnew)
* NONPARAMETRIC MEODELS
    * Diffeomorphic Spherical Regression
        * [Grid2,E,Xtilde,path] = NPSR(X,Y,lambda,l,NN)
    * Local Linear Regression
        * [m] = LocalLR(X,Y,Xnew,kappa)




