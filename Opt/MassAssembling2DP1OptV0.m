function M=MassAssembling2DP1OptV0(nq,nme,me,areas)
% function M=MassAssembling2DP1OptV0(nq,nme,me,areas)
%   Assembly of the Mass Matrix using P1-Lagrange finite elements
%   - OptV0 version (see report).
%
% Parameters:
%  nq: total number of nodes of the mesh,
%  nme: total number of triangles,
%  me: Connectivity array, 3-by-nme array.
%      me(jl,k) is the storage index of the jl-th  vertex 
%      of the k-th triangle in the array q of vertices coordinates,
%  areas: Array of areas, 1-by-nme array. areas(k) is the area 
%         of the k-th triangle.
%
% Return values:
%  M: Global mass matrix, nq-by-nq sparse matrix.
%
% Example:
%    Th=SquareMesh(10);
%    M=MassAssembling2DP1OptV0(Th.nq,Th.nme,Th.me,Th.areas);
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
M=sparse(nq,nq);
for k=1:nme
  I=me(:,k);
  M(I,I)=M(I,I)+ElemMassMat2DP1(areas(k));
end
