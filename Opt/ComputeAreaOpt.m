function area=ComputeAreaOpt(q,me)
% function area=ComputeAreaOpt(q,me)
%   Computation of areas of triangles in the mesh
%   - Optimized version
%
% Parameters:
%  q: Array of vertices coordinates, 2-by-nq array.
%     q(il,j) is the il-th coordinate of the j-th vertex, il in {1,2}
%     and j in {1,...,nq}.
%  me: Connectivity array, 3-by-nme array.
%      me(jl,k) is the storage index of the jl-th  vertex 
%      of the k-th triangle in the array q of vertices coordinates,
%      jl in {1,2,3} and k in {1,...,nme}.
%
% Return values:
%  area: Array of areas, 1-by-nme array. area(k) is the area 
%         of the k-th triangle.
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
c1 = q(:,me(1,:));
d21 = q(:,me(2,:))-c1;
d31 = q(:,me(3,:))-c1;
area = 0.5*(d21(1,:).*d31(2,:)-d21(2,:).*d31(1,:));
