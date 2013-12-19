function K=StiffElasAssembling2DP1base(nq,nme,q,me,areas,lambda,mu,Num)
% function K=StiffElasAssembling2DP1base(nq,nme,q,me,areas,lambda,mu,Num)
%   Assembly of the Stiffness Elasticity Matrix by P1-Lagrange finite elements
%   - basic version (see report).
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
%    lambda=1.; mu=1.;
%    Num=0; 
%    KK=StiffElasAssembling2DP1base(Th.nq,Th.nme,Th.q,Th.me,Th.areas,lambda,mu,Num);
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
K=sparse(2*nq,2*nq);
GetI=BuildIkFunc(Num,nq);
ElemStiffElasMat=BuildElemStiffElasMatFunc(Num);
C=[lambda+2*mu,lambda,0;lambda,lambda+2*mu,0;0,0,mu];
for k=1:nme
    MatElem=ElemStiffElasMat(q(:,me(:,k)),areas(k),C); 
    I=GetI(me,k);
    for il=1:6
        for jl=1:6
            K(I(il),I(jl))=K(I(il),I(jl))+MatElem(il,jl);           
        end
    end   
end

