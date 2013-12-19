function Ke=ElemStiffElasMatBb2DP1(ql,area,C)
% function [Elem]=ElemStiffElasMatBb2DP1(ql,area,C)
%  Computation of the element stiffness elasticity matrix for
%  P1-Lagrange method. 
%  The method for numbering the degrees of freedom is local bloc numbering.
%
%  Hooke's matrix :
%  C=[L + 2*M       L       0]
%    [      L L + 2*M       0]
%    [      0       0       M]
%  Numbering of local points in reference element is :
%    P=[(0, 0), (1, 0), (0, 1)]
%
% Parameters:
%  ql    	: array of coordinates of the vertices of the triangle, 2-by-3 matrix (double)
%  area 	: triangle area (double)
%  C            : Hooke's matrix (3-by-3 double)
%
% Return values:
%  Elem 	: element stiffness elasticity matrix, 6-by-6 matrix (double)
%
% Example: 
%    ql=[0 1 0;0 0 1];
%    area=1/2.;
%    lambda=1.; mu=1.;
%    C=[lambda+2*mu, lambda, 0;lambda, lambda + 2*mu, 0;0, 0, mu];
%    Elem=ElemStiffElasMatBb2DP1(ql,area,C);
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
u=ql(:,2)-ql(:,3);
v=ql(:,3)-ql(:,1); 
w=ql(:,1)-ql(:,2);
% Matrice des déformations (x par 2*area)
B=[u(2),v(2),w(2),0,0,0; ...
   0,0,0,-u(1),-v(1),-w(1); ...
   -u(1),-v(1),-w(1),u(2),v(2),w(2)];
Ke=B'*C*B/(4*area);
