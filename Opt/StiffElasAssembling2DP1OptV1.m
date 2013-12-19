function K=StiffElasAssembling2DP1OptV1(nq,nme,q,me,areas,lambda,mu,Num)
% function K=StiffElasAssembling2DP1OptV1(nq,nme,q,me,areas,lambda,mu,Num)
%   Assembly of the Stiffness Elasticity Matrix by P1-Lagrange finite elements
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
%  lambda: the first Lame coefficient in Hooke's law
%  mu: the second Lame coefficient in Hooke's law
%  Num: 
%    0 global alternate numbering with local alternate numbering (classical method), 
%    1 global block numbering with local alternate numbering,
%    2 global alternate numbering with local block numbering,
%    3 global block numbering with local block numbering.
%
% Return values:
%  K: Global stiffness elasticity matrix, (2xnq)-by-(2xnq) sparse matrix.
%
% Example:
%    Th=SquareMesh(10);
%    lambda=1; mu=1;
%    Num = 0; 
%    KK=StiffElasAssembling2DP1OptV0(Th.nq,Th.nme,Th.q,Th.me,Th.areas,lambda,mu,Num);
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
ElemStiffElasMat=BuildElemStiffElasMatFunc(Num);
C=[lambda+2*mu,lambda,0;lambda,lambda+2*mu,0;0,0,mu];
GetI=BuildIkFunc(Num,nq);
Ig=zeros(36*nme,1);Jg=zeros(36*nme,1);Kg=zeros(36*nme,1);
kk=1:36;
for k=1:nme
  Me=ElemStiffElasMat(q(:,me(:,k)),areas(k),C);
  I=GetI(me,k);
  jA=ones(6,1)*I;
  iA=jA';

  Ig(kk)=iA(:);
  Jg(kk)=jA(:);
  Kg(kk)=Me(:);
  kk=kk+36;
end
K=sparse(Ig,Jg,Kg,2*nq,2*nq);
