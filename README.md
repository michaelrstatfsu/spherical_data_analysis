spherical\_data\_analysis
=======================

PARAMETRIC AND NONPARAMETRIC SPHERICAL REGRESSION WITH DIFFEOMORPHISMS
---------------------------------------------------------------------
By Michael Rosenthal

* Professor Co-Directing Dissertation
    * Anuj Srivastava
    * Wei Wu
* University Representative
    * Eric Klassen
* Committee Member
    * Debdeep Pati

ACKNOWLEDGMENTS
---------------------------------------------------------------------
I want to thank my committee members for their guidance, assistance, and patience. I will begin by thanking Dr. Srivastava who has always made time for me and put considerable effort in the development of my research and myself. I am inspired by how well he coordinates the many projects and events that he is involved in. I also want to thank Dr. Wu who has put in considerable effort in the asymptotic analysis results, and who has been helpful and encouraging to me. I don’t know where this project would be without Dr. Klassen, who’s mathematical insights have profoundly shaped the development of this research. I would also like to thank Dr. Pati for his interest and valuable insights. These people have all been excellent mentors to me, and I appreciate there effort and time

ABSTRACT
---------------------------------------------------------------------
Spherical regression explores relationships between pairs of variables on spherical domains. Spherical data has become more prevalent in biological, gaming, geographical, and meteorological investigations, creating a need for tools that analyze such data. Previous works on spherical regression have focused on rigid parametric models or nonparametric kernel smoothing methods. This leaves a huge gap in the available tools with no intermediate options currently available. This work will develop two such intermediate models, one parametric using projective linear transformation and one nonparametric model using diffeomorphic maps from a sphere to itself. The models are estimated in a maximum-likelihood framework using gradient-based optimizations. For the parametric model, an efficient Newton-Raphson algorithm is derived and asymptotic analysis is developed. A first-order roughness penalty is specified for the nonparametric model using the Jacobian of diffeomorphisms. The prediction performance of the proposed models are compared with state-of-the-art methods using simulated and real data involving plate tectonics, cloud deformations, wind, accelerometer, bird migration, and vector-cardiogram data.

DESCRIPTION OF REPOSITORY
---------------------------------------------------------------------
The purpose of this repository is to provide code for the analysis tools presented in my disseration with an emphasis on spherical regression. The objective is to make these tools more accessible so that investigators may be able to apply them to their own data. In the root folder of this directory, there are three main subdirectories. I will now breifly explain what is stored in each of those directories.

The MatLab\_Spherical\_Regression\_Code directory contains the main functions used to perform various anlaysis procedures. There are numerous examples demonstrating how the tools can be utilized to perform a spherical regression analysis.

The Data\_Modules directory contains modules written in Matlab which import spherical data from external sources into matlab. The modules in this directory depend on the main Matlab library MatLab\_Spherical\_Regression\_Code. A Matlab user should make sure that this the all of the subfolders of the spherical\_data\_analysis directory has been added to the Matlab path before running these modules. Each module has its own readme txt document which will describe how to run the module and what data is being collected.

* Wiimote Accellarometer Data
* Twitter Stream Data
* Radiosonde Data
* Magsat Data
* Hurricane Tracking Data

The R\_Spherical\_Regression_Code directory is not finished yet, but when it is completed it will contain a library of functions simliar to the tools developed in the MatLab\_Spherical\_Regression\_Code directory.


