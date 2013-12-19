function R=StiffAssembling2DP1OptV2(nq,nme,q,me,areas)
% function R=StiffAssemblingP1OptV2(nq,nme,q,me,areas)
%   Assembly of the Stiffness Matrix by P1-Lagrange finite elements
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
%
% Return values:
%  R: Global stiffness matrix, nq-by-nq sparse matrix.
%
% Example:
%    Th=SquareMesh(10);
%    R=StiffAssemblingP1OptV2(Th.nq,Th.nme,Th.q,Th.me,Th.areas);

%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
Ig = me([1 2 3 1 2 3 1 2 3],:);
Jg = me([1 1 1 2 2 2 3 3 3],:);

q1 =q(:,me(1,:)); q2 =q(:,me(2,:)); q3 =q(:,me(3,:));
u = q2-q3; v=q3-q1; w=q1-q2;
clear q1 q2 q3
areas4=4*areas;
Kg=zeros(9,nme);
Kg(1,:)=sum(u.*u,1)./areas4; % K1 ou G11
Kg(2,:)=sum(v.*u,1)./areas4; % K2 ou G12
Kg(3,:)=sum(w.*u,1)./areas4; % K3 ou G13
Kg(5,:)=sum(v.*v,1)./areas4; % K5 ou G22
Kg(6,:)=sum(w.*v,1)./areas4; % K6 ou G23
Kg(9,:)=sum(w.*w,1)./areas4; % K9 ou G33
Kg([4, 7, 8],:)=Kg([2, 3, 6],:);
R = sparse(Ig,Jg,Kg,nq,nq);
