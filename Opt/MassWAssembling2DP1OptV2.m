function M=MassWAssembling2DP1OptV2(nq,nme,me,areas,Tw)
% function M=MassWAssemblingP1OptV2(nq,nme,me,areas,Tw)
%   Assembly of the Weighted Mass Matrix by P1-Lagrange finite elements
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
%    Mw=MassWAssemblingP1OptV2(Th.nq,Th.nme,Th.me,Th.areas,Tw);
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
Ig = me([1 2 3 1 2 3 1 2 3],:);
Jg = me([1 1 1 2 2 2 3 3 3],:);
W=Tw(me).*(ones(3,1)*areas/30);
Kg=zeros(9,length(areas));
Kg(1,:)=3*W(1,:)+W(2,:)+W(3,:);
Kg(2,:)=W(1,:)+W(2,:)+W(3,:)/2;
Kg(3,:)=W(1,:)+W(2,:)/2+W(3,:);
Kg(5,:)=W(1,:)+3*W(2,:)+W(3,:);
Kg(6,:)=W(1,:)/2+W(2,:)+W(3,:);
Kg(9,:)=W(1,:)+W(2,:)+3*W(3,:);
Kg([4, 7, 8],:)=Kg([2, 3, 6],:);
M = sparse(Ig,Jg,Kg,nq,nq);
