function M=MassAssembling2DP1OptV2(nq,nme,me,areas)
% function M=MassAssemblingP1OptV2(nq,nme,me,areas)
%   Assembly of the Mass Matrix using P1-Lagrange finite elements
%   - OptV2 version (see report).
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
%    M=MassAssemblingP1OptV2(Th.nq,Th.nme,Th.me,Th.areas);
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
Ig = me([1 2 3 1 2 3 1 2 3],:);
Jg = me([1 1 1 2 2 2 3 3 3],:);
a6=areas/6;
a12=areas/12;
Kg = [a6;a12;a12;a12;a6;a12;a12;a12;a6];
M = sparse(Ig,Jg,Kg,nq,nq);
