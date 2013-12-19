function [Ig,Jg]=BuildIgJgP1VF(Num,me,nq)
% function [Ig,Jg]=BuildIgJgP1VF(Num,me,nq)
%   Definition of the arrays Ig and Jg, depending on the
%   parameter Num of global numbering of degrees of freedom.
%
% Parameters:
% Num: Choice of the numbering of degrees of freedom
%    - 0 local numbering (classical method)
%    - 1 global numbering
% nq: total number of nodes of the mesh,
% me: Connectivity array, 3-by-nme array.
%      me(jl,k) is the storage index of the jl-th  vertex 
%      of the k-th triangle in the array q of vertices coordinates,
%
% Return values:
% Ig : Array of indices, 2ndf-by-nmef  array
% Jg : Array of indices, 2ndf-by-nmef  array
%
% Example:
%    Th=SquareMesh(10);
%    [Ig,Jg]=BuildIgJgP1VF(0,Th.nme,Th.nq);

%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
switch Num
case 0
  GetI=@(me) [2*me(1,:)-1; 2*me(1,:); 2*me(2,:)-1; 2*me(2,:); 2*me(3,:)-1; 2*me(3,:)];
case 1
  GetI=@(me) [me(1,:); me(1,:)+nq; me(2,:); me(2,:)+nq; me(3,:); me(3,:)+nq];
case 2
  GetI=@(me) [2*me(1,:)-1; 2*me(2,:)-1; 2*me(3,:)-1; 2*me(1,:); 2*me(2,:); 2*me(3,:)];
case 3
  GetI=@(me) [me(1,:); me(2,:); me(3,:); me(1,:)+nq; me(2,:)+nq; me(3,:)+nq];
end
ii=[1:6]'*ones(1,6);
ii=ii(:);
jj=ones(6,1)*[1:6];
jj=jj(:);

I=GetI(me);

Ig=I(ii,:);
Ig=Ig(:);
Jg=I(jj,:);
Jg=Jg(:);
