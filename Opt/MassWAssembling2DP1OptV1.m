function M=MassWAssembling2DP1OptV1(nq,nme,me,areas,Tw)
% function M=MassWAssembling2DP1OptV1(nq,nme,me,areas,Tw)
%   Assembly of the Weighted Mass Matrix by P1-Lagrange finite elements
%   - OptV1 version (see report).
%
% Parameters:
%  nq: total number of nodes of the mesh,
%  nme: total number of triangles,
%  me: Connectivity array, 3-by-nme array.
%      me(jl,k) is the storage index of the jl-th  vertex 
%      of the k-th triangle in the array q of vertices coordinates.
%  areas: Array of areas, 1-by-nme array (double). areas(k) is the area 
%         of the k-th triangle.
%  Tw: Array containing weigthed values at vertices,
%      1-by-nq array.
%
% Return values:
%  M: Global weighted mass matrix, nq-by-nq sparse matrix.
%
% Example: 
%    Th=SquareMesh(10);
%    w=@(x,y) cos(x+y);
%    Tw=w(Th.q(1,:),Th.q(2,:));
%    Mw=MassWAssembling2DP1OptV1(Th.nq,Th.nme,Th.me,Th.areas,Tw);
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
Ig=zeros(9*nme,1);Jg=zeros(9*nme,1);Kg=zeros(9*nme,1);

ii=[1 2 3 1 2 3 1 2 3];
jj=[1 1 1 2 2 2 3 3 3];
kk=1:9;
for k=1:nme
  E=ElemMassWMat2DP1(areas(k),Tw(me(:,k)));
  Ig(kk)=me(ii,k); 
  Jg(kk)=me(jj,k);
  Kg(kk)=E(:);
  kk=kk+9;
end
M=sparse(Ig,Jg,Kg,nq,nq);

