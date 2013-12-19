function R=StiffAssembling2DP1OptV1(nq,nme,q,me,areas)
% function R=StiffAssemblingP1OptV1(nq,nme,q,me,areas)
%   Assembly of the Stiffness Matrix by P1-Lagrange finite elements
%   - OptV1 version (see report).
%
% Parameters:
%  nq: total number of nodes of the mesh,
%  nme: total number of triangles,
%  q: Array of vertices coordinates, 2-by-nq array.
%     q(il,j) is the il-th coordinate of the j-th vertex, il in {1,2}
%     and j in {1,...,nq}.
%  me: Connectivity array, 3-by-nme array.
%      me(jl,k) is the storage index of the jl-th  vertex 
%      of the k-th triangle in the array q of vertices coordinates,
%  areas: Array of areas, 1-by-nme array. areas(k) is the area 
%         of the k-th triangle.
%
% Return values:
%  R: Global stiffness matrix, nq-by-nq sparse matrix.
%
% Example:
%    Th=SquareMesh(10);
%    R=StiffAssemblingP1OptV1(Th.nq,Th.nme,Th.q,Th.me,Th.areas);

%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
Ig=zeros(nme*9,1);Jg=zeros(nme*9,1);
Kg=zeros(nme*9,1);

ii=[1 2 3 1 2 3 1 2 3];
jj=[1 1 1 2 2 2 3 3 3];
kk=1:9;
for k=1:nme
  Me=ElemStiffMat2DP1(q(:,me(1,k)),q(:,me(2,k)),q(:,me(3,k)),areas(k));
  Ig(kk)=me(ii,k); 
  Jg(kk)=me(jj,k);
  Kg(kk)=Me(:);
  kk=kk+9;
end
R=sparse(Ig,Jg,Kg,nq,nq);
