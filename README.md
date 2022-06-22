# USER GUIDE
The code for all the models developed in this project, are in this repository. The models were tested using synthetic and real data.

## Synthetic Data
For the synthetic data, there are four different models: Ellipsoidal uncertainty set, ball uncertainty set, polytopic uncertainty set and a mutliple ellipsoidal uncertainty set. For each uncertianty set, there is a main, calling function and a confidence function. Additonally, for the ellipsoidal and ball uncertainty set, there is a function for minimising the volume of the geometry. The files required for each uncertainty set are outlined below. All of the files for each uncertainty set must be run from the same directory. 

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


## Real Data
The code for the real data is almost identical and the structyre is very similar as the synthetic data. 
  

