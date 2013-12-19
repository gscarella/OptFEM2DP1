function lbe=EdgeLength(be,q)
% function lbe=EdgeLength(be,q)
%   Computation of the lengths of edges in the mesh
%   - Basic version
%   
% Parameters:
%  be: Connectivity array for boundary edges, 2-by-nbe array.
%      be(il,l) is the storage index of the il-th  vertex 
%      of the l-th edge in the array q of vertices coordinates,
%      il in {1,2} and l in {1,...,nbe}.
%  q: Array of vertices coordinates, 2-by-nq array.
%     q(il,j) is the il-th coordinate of the j-th vertex, il in {1,2}
%     and j in {1,...,nq}.
% 
% Return values:
%  lbe: Array of edges lengths, 1-by-nbe array. lbe(j) is
%       the length of the j-th edge.
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details

  nbe=size(be,2);
  lbe=zeros(1,nbe);
  for i=1:nbe
    lbe(i)=norm(q(:,be(1,i)) - q(:,be(2,i)),2);
  end
