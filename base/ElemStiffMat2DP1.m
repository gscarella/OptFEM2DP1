function AElem=ElemStiffMat2DP1(q1,q2,q3,area)
% function AElem=ElemStiffMat2DP1(q1,q2,q3,area)
%   Computation of the element stiffness matrix for
%   P1-Lagrange finite elements
%
% Parameters:
%  q1: Coordinates of the first vertex in the triangle,  2-by-1 array 
%  q2: Coordinates of the second vertex in the triangle, 2-by-1 array 
%  q3: Coordinates of the third vertex in the triangle,	 2-by-1 array 
%  area: triangle area
%
% Return values:
%  AElem: Element stiffness matrix, 3-by-3 matrix.
%
% Example: 
%    q1=[0;0];q2=[1;0];q3=[0;1];
%    area=1/2.;
%    AElem=ElemStiffMat2DP1(q1,q2,q3,area);
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
M=[q2-q3, q3-q1, q1-q2];
AElem=(1/(4*area))*M'*M;
