function runValids(varargin)
% function runValids(varargin)
%   Run validation tests for Mass, MassW, Stiff and StiffElas matrices.
%
% Parameters:
%   save    :  set to true to save figures in image directory.
%   percent :  value for resizing the figure (only png format). 
%              See SaveFigure function for details.
%
% Examples:
%  - runValids()
%  - runValids('save',true)
%  - runValids('save',true,'percent',75)
%
% See also:
%   validMass2DP1, validMassW2DP1, validStiff2DP1, validStiffElas2DP1, SaveFigure, InitOptFEM2DP1
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
InitOptFEM2DP1();

p = inputParser; 
  
if isOctave()
  p=p.addParamValue('save', false, @islogical );
  p=p.addParamValue('percent', 50 , @(t) ((t>0)&&(t<=100)) );
  p=p.parse(varargin{:});
else % Matlab
  p.addParamValue('save', false, @islogical );
  p.addParamValue('percent', 50 , @(t) ((t>0)&&(t<=100)) );
  p.parse(varargin{:});
end
close all

figure(1)
validMass2DP1();
SaveFigure(p.Results.save,'validMass2DP1',p.Results.percent)
figure(2)
validMassW2DP1();
SaveFigure(p.Results.save,'validMassW2DP1',p.Results.percent)
figure(3)
validStiff2DP1();
SaveFigure(p.Results.save,'validStiff2DP1',p.Results.percent)
figure(4)
validStiffElas2DP1(0);
SaveFigure(p.Results.save,'validStiffElas2DP1',p.Results.percent)
