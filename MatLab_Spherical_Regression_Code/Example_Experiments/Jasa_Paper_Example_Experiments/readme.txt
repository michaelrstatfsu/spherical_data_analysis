The Example_Experiments Directory contains script and data for repeating the data experiments found in the JASA paper titled

"Spherical Regression Models Using Projective Linear Transformations"
Michael Rosenthal*, Wei Wu*, Eric Klassen**, and Anuj Srivastava*
* Dept. of Statistics,
** Dept. of Mathematics, 
Florida State University

Each data example has it's own data module script which depends on functions found in the Spherical_Regression_Library.

(1) example_clouds            
    Contains examples of cloud formations data modules used in section 4.1
    Landmarks were selected from cylindrical projection maps of clouds composited from 
    http://visibleearth.nasa.gov/view.php?id=73909

(2) examples_shape_classification 
    Contains a module for repeating the shape classification experiment.

(3) example_simulated         
    Contains a module for repeating the simulated experiments used in section 2.4

(4) examples_vector_cardiogram
    Contains a module for repeating the vector-cardiogram experiments used in section 4.3
    The data in this experiment has been graciously provided by Peter Jupp at
    http://www.mcs.st-and.ac.uk/~pej/vcg.html
    The module contains code for importing the given data and exporting the data into mat format.
    
(5) examples_plate_tectonics
    Contains examples of plate techtonic data modules used in section 4.2
    Landmarks were selected from cylindrical projection maps of topological earthmaps from 
    http://visibleearth.nasa.gov/view.php?id=73909
