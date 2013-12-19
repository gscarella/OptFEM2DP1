function bool=isOctave()
% function bool=isOctave()
%   To determine whether Octave is used or not
%   
% Return values:
%  bool: if true Octave is used else Matlab is
%
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
log=ver;
bool=strcmp(log(1).Name,'Octave');
