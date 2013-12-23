

                                                OptFEM2DP1


             OptFEM2DP1 is a MATLAB/GNU Octave library providing simple and efficient
	         vectorized routines for P1-Lagrange Finite Element Methods in 2D
		 

This toolbox contains different optimization techniques to perform the assembly
of P1 finite element matrices in Matlab and Octave,  from the standard approach (basic version and OptV0)
to recent vectorized ones (OptV1 and OptV2), without any low level language used.
The more efficient version (OptV2) is entirely vectorized (without loop) and without any quadrature formula.

Versions
----------
  * Version 1.2b3 (under developement)
    We add the assembly of the Stiffness Elasticity Matrix
  * Version 1.1  
    We have implemented the assembly of :
    - the Mass Matrix, 
    - the Weighted Mass Matrix,
    - the Stiffness Matrix.

Requirements
--------------
    Needs Matlab or GNU Octave 3.6.*
    see F. Cuvelier homepage <www.math.univ-paris13.fr/~cuvelier>

Testing and Working
----------------------
    Ubuntu 12.04 LTS (x86_64) with
        Matlab R2013b
        Matlab R2013a
        Matlab R2012b
        Matlab R2012a
        Matlab R2011b
        Matlab R2011a
        GNU Octave 3.6.4
        GNU Octave 3.6.3
    Works on Windows 7 64 bits with
        Matlab R2012b
        Matlab R2012a
        GNU Octave 3.6.2

Quick testing
---------------
To test the OptFEM2DP1 library, you can run

* validation tests : runValids() 

* some benchmarks  : runBenchs()

Documentation
---------------
This version is with html documentation.

* To see the code documentation :
    open in a web browser the file doc/index.html
    
* To see the code documentation online :
   <http://www.math.univ-paris13.fr/~cuvelier/docs/Recherch/FEM2Dtoolbox/doc/V1.2b3/index.html>

* To get the code documentation :
   <http://hal.archives-ouvertes.fr/hal-00785101> 

License issues
-----------------
OptFEM2DP1 is published under the terms of the GNU General Public License.

OptFEM2DP1 is free software: you can redistribute it and/or modify it under the terms
of the GNU General Public License as published by the Free Software Foundation,
either version 3 of the License, or (at your option) any later version.

OptFEM2DP1 is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.
If not, see http://www.gnu.org/licenses/.

Software using source files of this project or significant parts of it,
should include the following attribution notice:

% ---------------------------------------------------------------------------------------------
% ATTRIBUTION NOTICE:
% This product includes software developed for the OptFEM2DP1 project at
% (C) University Paris XIII, Galilee Institute, LAGA, France.
%
% OptFEM2DP1 is a MATLAB/Octave software package for P1-Lagrange Finite Element Methods in 2D.
% The project is maintained by
% F. Cuvelier, C. Japhet and G. Scarella.
% For Online Documentation and Download we refer to
% <http://www.math.univ-paris13.fr/~cuvelier>
% ---------------------------------------------------------------------------------------------

    
