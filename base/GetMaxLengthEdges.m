function h=GetMaxLengthEdges(q,me)
% function h=GetMaxLengthEdges(q,me)
%   Computation of the maximal value of edge lengths
%   
% Parameters:
%  q: Array of vertices coordinates, 2-by-nq array.
%     q(il,j) is the il-th coordinate of the j-th vertex, il in {1,2}
%     and j in {1,...,nq}.
%  me: Connectivity array, 3-by-nme array (int32)
%      me(jl,k) is the storage index of the jl-th  vertex 
%      of the k-th triangle in the array q of vertices coordinates,
%      jl in {1,2,3} and k in {1,...,nme}.
% 
% Return values:
%  h: maximal length of an edge in the mesh
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
U=q(:,me(1,:))-q(:,me(2,:));
V=q(:,me(2,:))-q(:,me(3,:));
W=q(:,me(3,:))-q(:,me(1,:));

h=sqrt(max([sum(U.^2,1),sum(W.^2,1),sum(W.^2,1)]));

