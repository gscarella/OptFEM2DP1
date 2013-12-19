function AElem=ElemMassWMat2DP1(area,w)
% function AElem=ElemMassWMat2DP1(area,w)
%   Computation of the element weighted mass matrix for
%   P1-Lagrange finite elements
%   
% Parameters:
%  area: triangle area.
%  w: values of the weight function at the triangle vertices,
%  3-by-1 array.
%  
% Return values:
%  AElem: Element weighted mass matrix, 3-by-3 matrix.
%
% Example:
%    area=1/2.;
%    w=ones(3,1);
%    AElem=ElemMassWMat2DP1(area);
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
  AElem=(area/30)*[ 3*w(1)+w(2)+w(3), w(1)+w(2)+w(3)/2, w(1)+w(2)/2+w(3); ...
                    w(1)+w(2)+w(3)/2, w(1)+3*w(2)+w(3), w(1)/2+w(2)+w(3); ...
                    w(1)+w(2)/2+w(3), w(1)/2+w(2)+w(3), w(1)+w(2)+3*w(3)];
