function validStiff2DP1()
% function validStiff2DP1()
%  Validation function for the assembly of the stiffness matrix for
%  P1-Lagrange finite element method
%
%   The Stiffness Matrix (S) is computed by functions StiffAssembling2DP1{Version} where {Version} is one of
%     {'base', 'OptV0', 'OptV1','OptV2'}.
%     - Test 1: Computation of the Stiffness Matrix using all the versions giving errors and computation times
%     - Test 2: Approximation of the integral of grad(u).grad(v) on unit square using by
%                    dot(S*U,V)
%       where U=u(Th.q(1,:),Th.q(2,:))' and V=v(Th.q(1,:),Th.q(2,:))'.
%       Functions u and v are those defined in valid_FEMmatrices. .
%     - Test 3: One retrieves the order 2 of P1-Lagrange integration 
%
% See also:
%   StiffAssembling2DP1base, StiffAssembling2DP1OptV0,
%   StiffAssembling2DP1OptV1, StiffAssembling2DP1OptV2,
%   valid_FEMmatrices, SquareMesh, GetMaxLengthEdges
% 
% author : Francois Cuvelier [2012-11-26]
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details

  disp('*******************************************')
  disp('*     Stiff Assembling P1 validations     *')
  disp('*******************************************')

  Th=SquareMesh(50);

% TEST 1
  disp('-----------------------------------------')
  disp('  Test 1: Matrices errors and CPU times  ')
  disp('-----------------------------------------')
  tic();
  Mbase=StiffAssembling2DP1base(Th.nq,Th.nme,Th.q,Th.me,Th.areas);
  T(1)=toc();
  tic();
  MOptV0=StiffAssembling2DP1OptV0(Th.nq,Th.nme,Th.q,Th.me,Th.areas);
  T(2)=toc();
  Test1.error(1)=norm(Mbase-MOptV0,Inf);
  Test1.name{1}='StiffAssembling2DP1OptV0';
  fprintf('    Error P1base vs OptV0 : %e\n',Test1.error(1))
  tic();
  MOptV1=StiffAssembling2DP1OptV1(Th.nq,Th.nme,Th.q,Th.me,Th.areas);
  T(3)=toc();
  Test1.error(2)=norm(Mbase-MOptV1,Inf);
  Test1.name{2}='StiffAssembling2DP1OptV1';
  fprintf('    Error P1base vs OptV1 : %e\n',Test1.error(2))
  tic();
  MOptV2=StiffAssembling2DP1OptV2(Th.nq,Th.nme,Th.q,Th.me,Th.areas);
  T(4)=toc();
  Test1.error(3)=norm(Mbase-MOptV2,Inf);
  Test1.name{3}='StiffAssembling2DP1OptV2';
  fprintf('    Error P1base vs OptV2 : %e\n',Test1.error(3))

  fprintf('    CPU times base (ref) : %3.4f (s)\n',T(1))
  fprintf('    CPU times OptV0       : %3.4f (s) - Speed Up X%3.3f\n',T(2),T(1)/T(2))
  fprintf('    CPU times OptV1       : %3.4f (s) - Speed Up X%3.3f\n',T(3),T(1)/T(3))
  fprintf('    CPU times OptV2       : %3.4f (s) - Speed Up X%3.3f\n',T(4),T(1)/T(4))
  checkTest1(Test1)

  M=Mbase;

% TEST 2
  disp('-----------------------------------------------------')
  disp('  Test 2: Validations by integration on [0,1]x[0,1]  ')
  disp('-----------------------------------------------------')
  Test=valid_FEMmatrices();
  for kk=1:length(Test)
    U=Test(kk).u(Th.q(1,:),Th.q(2,:));
    V=Test(kk).v(Th.q(1,:),Th.q(2,:));
    Test(kk).error=abs(Test(kk).Stiff-U*M*V');
    fprintf('    functions %d : u(x,y)=%s, v(x,y)=%s,\n           -> Stiff error=%e\n',kk,Test(kk).cu,Test(kk).cv,Test(kk).error);
  end
  checkTest2(Test)
  
% TEST 3
  disp('--------------------------------')
  disp('  Test 3: Validations by order  ')
  disp('--------------------------------')
  n=length(Test);
  u=Test(n).u;
  v=Test(n).v;
  ExSol=Test(n).Stiff;

  for k=1:10  
    Th=SquareMesh(50*k+50);
    fprintf('    Matrix size : %d\n',Th.nq);
    h(k)=GetMaxLengthEdges(Th.q,Th.me);
    tic();
    M=StiffAssembling2DP1OptV2(Th.nq,Th.nme,Th.q,Th.me,Th.areas);
    TT(k)=toc();
    U=u(Th.q(1,:),Th.q(2,:));
    V=v(Th.q(1,:),Th.q(2,:));
    Error(k)=abs(ExSol-U*M*V');
    fprintf('      StiffAssembling2DP1OptV2 CPU times : %3.3f(s)\n',TT(k));
    fprintf('      Error                            : %e\n',Error(k));
  end

  loglog(h,Error,'+-r',h,h*1.1*Error(1)/h(1),'-sm',h,1.1*Error(1)*(h/h(1)).^2,'-db')
  legend('Error','O(h)','O(h^2)')
  xlabel('h')
  title('Test 3 : Stiffness Matrix')
  checkTest3(h,Error)
end

function checkTest1(Test)
  I=find(Test.error>1e-14);
  if isempty(I)
    disp('------------------------')
    disp('  Test 1 (results): OK')
    disp('------------------------')
  else
    disp('----------------------------')
    disp('  Test 1 (results): FAILED')
    disp('----------------------------')
  end
end

function checkTest2(Test)
  N=length(Test);
  cntFalse=0;
  for k=1:N
    if ( ismember(Test(k).degree,[0 1]) )
      if (Test(k).error>1e-12)
        cntFalse=cntFalse+1;
      end
    end
  end
  if (cntFalse==0)
    disp('------------------------')
    disp('  Test 2 (results): OK')
    disp('------------------------')
  else
    disp('----------------------------')
    disp('  Test 2 (results): FAILED')
    disp('----------------------------')
  end
end

function checkTest3(h,error)
  % order 2
  P=polyfit(log(h),log(error),1);
  if abs(P(1)-2)<1e-2
    disp('------------------------')
    disp('  Test 3 (results): OK')
    fprintf('    -> found numerical order %f. Must be 2\n',P(1))
    disp('------------------------')
  else
    disp('----------------------------')
    disp('  Test 3 (results): FAILED')
    fprintf('    -> found numerical order %f. Must be 2\n',P(1))
    disp('----------------------------')
  end
end
