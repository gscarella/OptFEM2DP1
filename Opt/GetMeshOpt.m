function Mesh=GetMeshOpt(cFileName)
% function Mesh=GetMesh(cFileName)
% Initialization of the Mesh structure from a FreeFEM++ mesh file 
% - Optimized version
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
%  nq: total number of vertices
%  nme: total number of elements
%  nbe: total number of boundary edges
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

% Example:
%  @verbatim 
%    Th=GetMeshOpt('carre.msh')
%  @endverbatim
% @author François Cuvelier
%

  [fid,message]=fopen(cFileName,'r');
  if ( fid == -1 )
    error([message,' : ',cFileName]);
  end
  if isOctave()
  [n]=fscanf(fid,'%d %d %d',3);

  R=fscanf(fid,'%f %f %d',[3,n(1)]);
  q=R([1 2],:);
  ql=R(3,:);
  R=fscanf(fid,'%d %d %d %d',[4,n(2)]);

  me=R([1:3],:);
  mel=R(4,:);
  R=fscanf(fid,'%d %d %d',[3,n(3)]);
  
  be=R([1 2],:);
  bel=R(3,:);
  else % Matlab
  n=textscan(fid,'%d %d %d',1); % n(1) -> number of vertices
		      % n(2) -> number of triangles
		      % n(3) -> number of boundary edges
  
  R=textscan(fid,'%f %f %d',n{1});
  q=[R{1},R{2}]';
  ql=R{3}';
  R=textscan(fid,'%d %d %d %d',n{2});
  me=[R{1},R{2},R{3}]';
  mel=R{4}';

  R=textscan(fid,'%d %d %d',n{3});
  be=[R{1},R{2}]';
  bel=R{3}';
  end
  fclose(fid);

  Mesh=struct('q',q,'me',double(me),'ql',ql,'mel',double(mel), ...
              'be',double(be),'bel',double(bel), ...
              'nq',size(q,2), ...
              'nme',size(me,2), ...
              'nbe',size(be,2), ...
              'areas',ComputeAreaOpt(q,me),...
              'lbe',EdgeLength(be,q));

