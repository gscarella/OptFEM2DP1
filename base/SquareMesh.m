function Th=SquareMesh(N)
% function Th=SquareMesh(N)
% Initialization of the Mesh structure for a square domain
%
% Square domain is [0,1]x[0,1].
%
% This mesh has 4 boundary labels :
%   - label 1 : boundary y=0
%   - label 2 : boundary x=1
%   - label 3 : boundary y=1
%   - label 4 : boundary x=0
% There are N+1 points on each boundary.
%
% Parameters:
%  N: integer, number of elements on a boundary
%
% Return values:
%  Th: mesh structure
%
% Generated fields of mesh structure:
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
% See also
%  ComputeAreaOpt, EdgeLengthOpt
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
  h=1/N;t=0:h:1;
  if isOctave()
    mesh=msh2m_structured_mesh(t,t,1,1:4); % package msh
    me=mesh.t(1:3,:);
    q=mesh.p;
  else
    [x,y] = meshgrid(t,t);
    q=[x(:) y(:)]';
    tri = delaunay(x,y);
    me=tri';
  end
  
  nq=length(q);
  nme=length(me);
  
  ql=zeros(1,nq);
  be=zeros(2,4*N);
  bel=zeros(1,4*N);
  % Points du bord
  ql=zeros(1,nq);
  I=find(q(2,:)==0);
  ql(I)=1;
  be(:,1:N)=[I(1:end-1);I(2:end)];
  bel(:,1:N)=1;
  I=find(q(1,:)==1);
  ql(I)=2;
  be(:,N+1:2*N)=[I(1:end-1);I(2:end)];
  bel(:,N+1:2*N)=2;
  I=find(q(2,:)==1);
  ql(I)=3;
  I=fliplr(I);
  be(:,2*N+1:3*N)=[I(1:end-1);I(2:end)];
  bel(:,2*N+1:3*N)=3;
  I=find(q(1,:)==0);
  ql(I)=4;
  I=fliplr(I);
  be(:,3*N+1:4*N)=[I(1:end-1);I(2:end)];
  bel(:,3*N+1:4*N)=4;
  
  Th=struct('q',q,'me',me,'ql',ql,'mel',zeros(1,nme),'be',be,'bel',bel, ...
            'nq',size(q,2), ...
            'nme',size(me,2), ...
            'nbe',size(be,2), ...
            'areas',ComputeAreaOpt(q,me),...
            'lbe',EdgeLengthOpt(be,q));
  
