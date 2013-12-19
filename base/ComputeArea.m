function area=ComputeArea(q,me)
% function area=ComputeArea(q,me)
%   Computation of areas of triangles in the mesh
%   - Basic version.
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
%        of the k-th triangle.
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
nq=size(q,2);
nme=size(me,2);
area=zeros(1,nme);
for k=1:nme
  area(k)=0.5*abs(det([ q(1,me(1,k))  q(2,me(1,k)) 1 ; ...
                        q(1,me(2,k))  q(2,me(2,k)) 1 ; ...
                        q(1,me(3,k))  q(2,me(3,k)) 1 ]));
end
