function GetI=BuildIkFunc(Num,nq)
% function GetI=BuildIkFunc(Num,nq)
%   Definition of the GetI function depending on the
%   parameter Num of global numbering of degrees of freedom.
%   Used by StiffElasAssemblingP1 functions.
%
% Parameters:
% Num: Choice of the numbering of degrees of freedom
%    - 0 global alternate numbering with local alternate numbering (classical method), 
%    - 1 global block numbering with local alternate numbering,
%    - 2 global alternate numbering with local block numbering,
%    - 3 global block numbering with local block numbering.
% nq: total number of vertices, also denoted by `\nq`.
%
% See report 

%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
switch Num
case 0
  GetI=@(me,k) [2*me(1,k)-1, 2*me(1,k), 2*me(2,k)-1, 2*me(2,k), 2*me(3,k)-1, 2*me(3,k)];
case 1
  GetI=@(me,k) [me(1,k) me(1,k)+nq me(2,k) me(2,k)+nq me(3,k) me(3,k)+nq];
case 2
  GetI=@(me,k) [2*me(:,k)-1;2*me(:,k)]';
case 3
  GetI=@(me,k) [me(:,k); me(:,k)+nq]';
end
