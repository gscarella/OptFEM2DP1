function [lambda,mu]=Compute_Lame(E,nu,alpha)
% function [lambda,mu]=Compute_Lame(E,nu,alpha)
% Computation of Lame coefficients from Young's modulus and Poisson's ratio
%
%
% Parameters:
%  E: Young's modulus
%  nu: Poisson's ratio
%  alpha: parameter such that alpha=1 <=> plane strain, alpha=0 <=> plane stress
%
% Return values:
%  lambda: First Lame coefficient in Hooke's law
%  mu: Second Lame coefficient in Hooke's law
%
% Example:
%  We consider the example of steel with plane strain hypothesis.
%    Th=SquareMesh(10);
%    E=2.1*1e11; nu=0.27; alpha=1;
%    [lambda,mu]=Compute_Lame(E,nu,alpha);
%    Num=0;
%    K=StiffElasAssemblingP1base(Th.nq,Th.nme,Th.q,Th.me,Th.areas,lambda,mu,Num);
%
% See also:
%   SquareMesh, StiffElasAssemblingP1base
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
if(alpha==0)
    disp('Plane stress');
else
    disp('Plane strain');
end
lambda=E*nu/((1+nu)*(1-(1+alpha)*nu));
mu=E/(2*(1+nu));
end
