function bench=benchStiffElas2DP1(varargin)
% function benchStiffElas2DP1()
%   Benchmark function for StiffElasAssembling2DP1 functions.
%
% Parameters:
%   Num 
%    - 0 global alternate numbering with local alternate numbering (classical method), 
%    - 1 global block numbering with local alternate numbering,
%    - 2 global alternate numbering with local block numbering,
%    - 3 global block numbering with local block numbering.
%
% See also:
%   StiffElasAssembling2DP1base, StiffElasAssembling2DP1OptV0, StiffElasAssembling2DP1OptV1, StiffElasAssembling2DP1OptV2
%   SquareMesh
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details

  p = inputParser; 
  
  if isOctave()
    p=p.addParamValue('LN', [20:20:100] , @isnumeric );
    p=p.addParamValue('Num', 0 , @isnumeric );
    p=p.parse(varargin{:});
  else % Matlab
    p.addParamValue('LN', [20:20:100], @isnumeric );
    p.addParamValue('Num', 0, @isnumeric );
    p.parse(varargin{:});
  end
  Num=p.Results.Num;

  switch Num
    case 0
      s=sprintf('Global alternate numbering / local alternate numbering');
    case 1
      s=sprintf('Global block numbering / local alternate numbering');
    case 2
      s=sprintf('Global alternate numbering / local block numbering');
    case 3
      s=sprintf('Global block numbering / local block numbering');
    otherwise
      error('invalid Num value')
  end
  
  k=1;
  for N=p.Results.LN   
    Th=SquareMesh(N);
    fprintf('---------------------------------------------------------\n')
    fprintf('BENCH (Stiff Elas. Matrix Assembling) %d\n',k)
    fprintf(' Numbering Choice : %s\n',s);
    fprintf(' Vertices number : %d - Triangles number : %d\n',Th.nq,Th.nme)
    Lnq(k)=Th.nq;
    tic();
    Mb=StiffElasAssembling2DP1base(Th.nq,Th.nme,Th.q,Th.me,Th.areas,1,1,Num);
    T(k,1)=toc();
    fprintf(' Matrix size     : %d\n',length(Mb))
    fprintf('    CPU times base (ref) : %3.4f (s)\n',T(k,1))
    Ldof(k)=length(Mb);
    tic();
    M=StiffElasAssembling2DP1OptV0(Th.nq,Th.nme,Th.q,Th.me,Th.areas,1,1,Num);
    T(k,2)=toc();
    fprintf('    CPU times OptV0      : %3.4f (s) - Error = %e - Speed Up X%3.3f\n',T(k,2),norm(Mb-M,Inf),T(k,1)/T(k,2))
    tic();
    M=StiffElasAssembling2DP1OptV1(Th.nq,Th.nme,Th.q,Th.me,Th.areas,1,1,Num);
    T(k,3)=toc();
    fprintf('    CPU times OptV1      : %3.4f (s) - Error = %e - Speed Up X%3.3f\n',T(k,3),norm(Mb-M,Inf),T(k,1)/T(k,3))
    tic();
    M=StiffElasAssembling2DP1OptV2(Th.nq,Th.nme,Th.q,Th.me,Th.areas,1,1,Num);
    T(k,4)=toc();
    fprintf('    CPU times OptV2      : %3.4f (s) - Error = %e - Speed Up X%3.3f\n',T(k,4),norm(Mb-M,Inf),T(k,1)/T(k,4))
    k=k+1;
  end
  
  bench.T=T;
  bench.Lnq=Lnq;
  bench.Ldof=Ldof;
  bench.LN=p.Results.LN;
