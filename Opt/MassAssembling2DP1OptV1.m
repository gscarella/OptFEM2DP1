function M=MassAssembling2DP1OptV1(nq,nme,me,areas)
% function M=MassAssemblingP1OptV1(nq,nme,me,areas)
%   Assembly of the Mass Matrix using P1-Lagrange finite elements
%   - OptV1 version (see report).
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
%    M=MassAssemblingP1OptV1(Th.nq,Th.nme,Th.me,Th.areas);
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
Ig=zeros(9*nme,1);Jg=zeros(9*nme,1);Kg=zeros(9*nme,1);

ii=[1 2 3 1 2 3 1 2 3];
jj=[1 1 1 2 2 2 3 3 3];
kk=1:9;
for k=1:nme
  E=ElemMassMat2DP1(areas(k));
  Ig(kk)=me(ii,k); 
  Jg(kk)=me(jj,k);
  Kg(kk)=E(:);
  kk=kk+9;
end
M=sparse(Ig,Jg,Kg,nq,nq);
%*****
