# USER GUIDE
The code for all the models developed in this project, are in this repository. The models were tested using synthetic and real data.
The main three files for each uncertainty set are the main, calling and confidence function. The purpose of each of these files is outlined below:

# MAIN
The main files are the files that are to be run to run the models. These files perform the optimsiation. 

# CALLING
The calling function prepares the data to create the uncertainty set. It also provides other model input parameters to the main. 

# CONFIDENCE
The confidence function adjusts the size of the uncertainty sets and is called from the calling function.


---------------------------------------------------------------------------------------------------------------------------------------------------------

## Synthetic Data
For the synthetic data, there are four different models: Ellipsoidal uncertainty set, ball uncertainty set, polytopic uncertainty set and a mutliple ellipsoidal uncertainty set. For each uncertianty set, there is a main, calling function and a confidence function. Additonally, for the ellipsoidal and ball uncertainty set, there is a function for minimising the volume of the geometry and a function for computing the volume of the two geometries. The files required for each uncertainty set are outlined below. All of the files for each uncertainty set must be run from the same directory. 

THE FILES FOR THE SYNETHIC DATA CAN BE FOUND IN THE 'SYNTHETIC' BRANCH
THE FILES FOR THE REAL DATA CAN BE FOUND IN THE 'REAL' BRANCH

### Ellipsoidal
- main_synethic.m
- calling_synthetic.m
- confidence_func.m
- MinVolEllipse.m
  -   This function was written by Nima Moshtagh.  (Nima Moshtagh (2022). Minimum Volume Enclosing Ellipsoid (https://www.mathworks.com/matlabcentral/fileexchange/9542-minimum-volume-enclosing-ellipsoid), MATLAB Central File Exchange. Retrieved June 22, 2022.)
 
 
### Ball
- main
- calling
- confidence
- MinVolBall.m

### Polytope
- main
- calling
- confidence 
- vert2lcon
    - This funcion was written by Matt. J. (Matt J (2022). Analyze N-dimensional Convex Polyhedra (https://www.mathworks.com/matlabcentral/fileexchange/30892-analyze-n-dimensional-convex-polyhedra), MATLAB Central File Exchange. Retrieved June 22, 2022.)

### Multiple Ellipsoidal



## Real Data
The code for the real data is almost identical and the structUre is very similar as the synthetic data. The code files for each uncertainty set are given below.

### Ellipsoidal
- main_real.m
- callingfunc_real.m
- confidence_func.m
- MinVolEllipse.m
- ellipse_volume


### Ball
- ball_volume.m
- main_sphere.m
- calling_sphere.m
- MinVolBall.m
- 

### Polytope
- main_polytope_facet.m
- calling_polytope_facet.m
- confidence_polytope_facet.m
- vert2lcon.m


### Multiple Ellipsoidal
- calling_multipleellipse.m
- callingfunc_real
- confidence_func.m
- ellipse_volume.m
- MinVolEllipse.m
- main_multipleellipse.m

### No Uncertainty
- main_NoUnc.m
- calling_NoUnc.m



csv: monthly_returns2.csv
  
Additionally, the csv file used for testing the real data is given in the Real Data folder of the repository. 


