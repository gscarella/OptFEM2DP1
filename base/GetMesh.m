function Mesh=GetMesh(cFileName)
% function Mesh=GetMesh(cFileName)
% Initialization of the Mesh structure from a FreeFEM++ mesh file 
% - Basic version
%
% Parameters:
%  cFileName: FreeFEM++ mesh file name (string)
%
% Return values:
%  Mesh: mesh structure
%
% Generated fields of Mesh:
%  q: Array of vertices coordinates, 2-by-nq array.
%     q(il,j) is the il-th coordinate of the j-th vertex, il in {1,2}
%     and j in {1,...,nq}.
%  me: Connectivity array, 3-by-nme array.
%      me(jl,k) is the storage index of the jl-th  vertex 
%      of the k-th triangle in the array q of vertices coordinates,
%      jl in {1,2,3} and k in {1,...,nme}.
%  ql: Array of vertices labels, 1-by-nq array.
%  mel: Array of elements labels, 1-by-nme array.
%  be: Connectivity array for boundary edges, 2-by-nbe array.
%      be(il,l) is the storage index of the il-th  vertex 
%      of the l-th edge in the array q of vertices coordinates,
%      il in {1,2} and l in {1,...,nbe}.
%  bel: Array of boundary edges labels, 1-by-nbe array. 
%  nq: total number of vertices.
%  nme: total number of elements.
%  nbe: total number of boundary edges.
%  areas: Array of areas, 1-by-nme array. areas(k) is the area 
%         of the k-th triangle.
%  lbe: Array of edges lengths, 1-by-nbe array. lbe(j) is
%       the length of the j-th edge.
%
% Example:
%    Th=GetMesh('carre.msh')

%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
[fid,message]=fopen(cFileName,'r');
if ( fid == -1 )
  error([message,' : ',cFileName]);
end
n=fscanf(fid,'%d',3); ; % n(1) -> number of vertices	
		      % n(2) -> number of triangles	
		      % n(3) -> number of boundary edges
me=zeros(3,n(2));
ql=zeros(1,n(1));
q=zeros(2,n(1));
mel=zeros(1,n(2));
for i=1:n(1)
  d_tmp=fscanf(fid,'%g',2);
  q(1,i)=d_tmp(1);
  q(2,i)=d_tmp(2);
  ql(i)=fscanf(fid,'%d',1);
end
for i=1:n(2)
  i_tmp=fscanf(fid,'%d',4);
  me(1,i)=i_tmp(1);
  me(2,i)=i_tmp(2);
  me(3,i)=i_tmp(3);
  mel(i)=i_tmp(4);
end

for i=1:n(3)
  i_tmp=fscanf(fid,'%d',3);
  be(1,i)=i_tmp(1);
  be(2,i)=i_tmp(2);
  bel(i) =i_tmp(3);
end

fclose(fid);

Mesh=struct('q',q,'me',me,'ql',ql,'mel',mel,'be',be,'bel',bel, ...
            'nq',size(q,2), ...
            'nme',size(me,2), ...
            'nbe',size(be,2), ...
            'areas',ComputeArea(q,me),...
            'lbe',EdgeLength(be,q));
