function ElemStiffElasMat=BuildElemStiffElasMatFunc(Num)
% function ElemStiffElasMat=BuildElemStiffElasMatFunc(Num)
%   Definition of the ElemStiffElasMat function depending on the
%   parameter Num of numbering of degrees of freedom.
%
% Parameters:
% Num: Choice of the local numbering of degrees of freedom 
%    - 0, 1 alternate numbering (classical method), 
%    - 2, 3 block numbering
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
switch Num
case {0,1}
  ElemStiffElasMat=@(ql,area,C) ElemStiffElasMatBa2DP1(ql,area,C);
case {2,3}
  ElemStiffElasMat=@(ql,area,C) ElemStiffElasMatBb2DP1(ql,area,C);
end
