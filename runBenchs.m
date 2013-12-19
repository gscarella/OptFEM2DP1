function runBenchs(varargin)
% function runBenchs()
%   Run benchs for Mass, MassW, Stiff and StiffElas matrices.
%   For each assembly matrix, we compare computation times of corresponding functions 
%   for version 'base', 'OptV0', 'OptV1' and 'OptV2'.
%
% Optional parameter:
%   save      : true for saving each bench in latex files. (default false)
%   directory : name of the directory for saving LaTeX files.
%   name      : base name of LaTeX files.
%   LN        : List of N parameters for #SquareMesh function.
%
% Example:
%   runBenchs('save',true,'name','benchMatlabR2012b','LN',20:20:160)
%
% See also:
%   benchMassP1, benchMassWP1, benchStiffP1, benchStiffElasP1, InitOptFEM2DP1
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
close all

InitOptFEM2DP1();

p = inputParser;
  
if isOctave()
  p=p.addParamValue('save', false, @islogical );
  p=p.addParamValue('directory', 'latex' , @ischar );
  p=p.addParamValue('name', 'bench' , @ischar );
  p=p.addParamValue('LN', [20:20:100] , @isnumeric );
  p=p.parse(varargin{:});
else % Matlab
  p.addParamValue('save', false, @islogical );
  p.addParamValue('directory', 'latex' , @ischar );
  p.addParamValue('name', 'bench' , @ischar );
  p.addParamValue('LN', [20:20:100], @isnumeric );
  p.parse(varargin{:});
end
LN=p.Results.LN;
if p.Results.save
  [succes,message,messageid] = mkdir(p.Results.directory);
  if (~succes)
    error(message)
  end  
end
BenchMassP1=benchMass2DP1('LN',LN);
if p.Results.save
  % Build LaTeX tabular
  BenchToLatexTabular(BenchMassP1,[p.Results.directory,filesep,p.Results.name,'_Mass2DP1.tex']);
end

BenchMassWP1=benchMassW2DP1('LN',LN);
if p.Results.save
  % Build LaTeX tabular
  BenchToLatexTabular(BenchMassWP1,[p.Results.directory,filesep,p.Results.name,'_MassW2DP1.tex']);
end

BenchStiffP1=benchStiff2DP1('LN',LN);
if p.Results.save
  % Build LaTeX tabular
  BenchToLatexTabular(BenchStiffP1,[p.Results.directory,filesep,p.Results.name,'_Stiff2DP1.tex']);
end

BenchStiffElasP1=benchStiffElas2DP1('LN',LN);
if p.Results.save
  % Build LaTeX tabular
  BenchToLatexTabular(BenchStiffElasP1,[p.Results.directory,filesep,p.Results.name,'_StiffElas2DP1.tex']);
end
end

function BenchToLatexTabular(bench,LaTeXFilename)
  T=bench.T;
  Data=[bench.Ldof',T(:,1),T(:,1)./T(:,1),T(:,2),T(:,1)./T(:,2),T(:,3),T(:,1)./T(:,3),T(:,4),T(:,1)./T(:,4)];
  Header={'$n_{dof}$', 'base', 'OptV0', 'OptV1', 'OptV2'};
  DataFormat={'$%d$','\\begin{tabular}{c} %.3f (s)\\\\ \\texttt{x %.2f} \\end{tabular}', ...
                     '\\begin{tabular}{c} %.3f (s)\\\\ \\texttt{x %.2f} \\end{tabular}', ...
                     '\\begin{tabular}{c} %.3f (s)\\\\ \\texttt{x %.2f} \\end{tabular}', ...
                     '\\begin{tabular}{c} %.3f (s)\\\\ \\texttt{x %.2f} \\end{tabular}'};
  ColumnFormat= '|r||*{4}{c|}';
  RowFormat='\hline';
  RowHeaderFormat='\hline \hline';
  PrintDataInLatexTabular(Data,Header,DataFormat,ColumnFormat,RowFormat,RowHeaderFormat,LaTeXFilename)

end
