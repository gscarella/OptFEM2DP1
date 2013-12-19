function [K]=StiffElasAssembling2DP1OptV2(nq,nme,q,me,areas,lambda,mu,Num)
% function K=StiffElasAssembling2DP1OptV2(nq,nme,q,me,areas,lambda,mu,Num)
%   Assembly of the Stiffness Elasticity Matrix by P1-Lagrange finite elements
%   - OptV2 version (see report).
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
%    KK=StiffElasAssembling2DP1OptV2(Th.nq,Th.nme,Th.q,Th.me,Th.areas,lambda,mu,Num);
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
[Ig,Jg]=BuildIgJgP1VF(Num,me,nq);
switch Num
case {0,1}
  Kg=ElemStiffElasMatBaVec2DP1(q,me,areas,lambda,mu);
case {2,3}
  Kg=ElemStiffElasMatBbVec2DP1(q,me,areas,lambda,mu);
end
K = sparse(Ig(:),Jg(:),Kg(:),2*nq,2*nq);
