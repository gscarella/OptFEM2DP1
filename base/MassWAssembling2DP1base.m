function M=MassWAssembling2DP1base(nq,nme,me,areas,Tw)
% function M=MassWAssembling2DP1base(nq,nme,me,areas,Tw)
%   Assembly of the Weighted Mass Matrix by P1-Lagrange finite elements
%   - Basic version (see report).
%
% Parameters:
%  nq: total number of nodes of the mesh,
%  nme: total number of triangles,
%  me: Connectivity array, 3-by-nme array.
%      me(jl,k) is the storage index of the jl-th  vertex 
%      of the k-th triangle in the array q of vertices coordinates,
%      jl in {1,2,3} and k in {1,...,nme}.
%  areas: Array of areas, 1-by-nme array. areas(k) is the area 
%         of the k-th triangle.
%  Tw: Array containing weigthed values at vertices,
%      1-by-nq array
%
% Return values:
%  M: Global weighted mass matrix, nq-by-nq sparse matrix.
%
% Example: 
%    Th=SquareMesh(10);
%    w=@(x,y) cos(x+y);
%    Tw=w(Th.q(1,:),Th.q(2,:));
%    Mw=MassWAssembling2DP1base(Th.nq,Th.nme,Th.me,Th.areas,Tw);
%
% See also:
%   ElemMassWMat2DP1
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
M=sparse(nq,nq);
for k=1:nme
    for il=1:3
        i=me(il,k);
	Twloc(il)=Tw(i);
    end
    E=ElemMassWMat2DP1(areas(k),Twloc);
    for il=1:3
        i=me(il,k);
        for jl=1:3
            j=me(jl,k);
            M(i,j)=M(i,j)+E(il,jl);
        end
    end
end
