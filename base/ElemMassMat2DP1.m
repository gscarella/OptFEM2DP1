function AElem=ElemMassMat2DP1(area)
% function AElem=ElemMassMat2DP1(area)
%   Computation of the element mass matrix for
%   P1-Lagrange finite elements
%
% Parameters:
%  area: triangle area
%
% Return values:
%  AElem: Element mass matrix, 3-by-3 matrix
%
% Example:
%    area=1/2.;
%    AElem=ElemMassMat2DP1(area);
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
AElem=(area/12)*[2 1 1; 1 2 1; 1 1 2];
