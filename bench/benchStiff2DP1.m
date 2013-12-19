function bench=benchStiff2DP1(varargin)
% function benchStiff2DP1()
%   Benchmark function for StiffAssembling2DP1 functions.
%
% See also:
%   StiffAssembling2DP1base, StiffAssembling2DP1OptV0, StiffAssembling2DP1OptV1, StiffAssembling2DP1OptV2
%   SquareMesh
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
  p = inputParser; 
  
  if isOctave()
    p=p.addParamValue('LN', [20:20:100] , @isnumeric );
    p=p.parse(varargin{:});
  else % Matlab
    p.addParamValue('LN', [20:20:100], @isnumeric );
    p.parse(varargin{:});
  end
  k=1;
  for N=p.Results.LN  
    Th=SquareMesh(N);
    fprintf('---------------------------------------------------------\n')
    fprintf('BENCH (Stiffness Matrix Assembling) %d\n',k)
    fprintf(' Vertices number : %d - Triangles number : %d\n',Th.nq,Th.nme)
    fprintf(' Matrix size   : %d\n',Th.nq)
    Lnq(k)=Th.nq;
    tic();
    M=StiffAssembling2DP1base(Th.nq,Th.nme,Th.q,Th.me,Th.areas);
    T(k,1)=toc();
    Ldof(k)=length(M);
    fprintf('    CPU times base (ref) : %3.4f (s)\n',T(k,1))
    tic();
    M=StiffAssembling2DP1OptV0(Th.nq,Th.nme,Th.q,Th.me,Th.areas);
    T(k,2)=toc();
    fprintf('    CPU times OptV0      : %3.4f (s) - Speed Up X%3.3f\n',T(k,2),T(k,1)/T(k,2))
    tic();
    M=StiffAssembling2DP1OptV1(Th.nq,Th.nme,Th.q,Th.me,Th.areas);
    T(k,3)=toc();
    fprintf('    CPU times OptV1      : %3.4f (s) - Speed Up X%3.3f\n',T(k,3),T(k,1)/T(k,3))
    tic();
    M=StiffAssembling2DP1OptV2(Th.nq,Th.nme,Th.q,Th.me,Th.areas);
    T(k,4)=toc();
    fprintf('    CPU times OptV2      : %3.4f (s) - Speed Up X%3.3f\n',T(k,4),T(k,1)/T(k,4))
    k=k+1;
  end
  
  bench.T=T;
  bench.Lnq=Lnq;
  bench.Ldof=Ldof;
  bench.LN=p.Results.LN;
  
