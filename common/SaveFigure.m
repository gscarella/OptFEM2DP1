function SaveFigure(issave,Name,percent)
% function SaveFigure(issave,Name,percent)
%   To manage the saving of figures. Save in eps, jpg and png format.
%   
% Parameters:
%  issave: boolean. If true saving figure is done.
%  Name: name of the destination file without extension (string)
%  percent: value for resizing the figure (only png format under unix)
%
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
if issave
  [SUCCESS,MESSAGE,MESSAGEID] = mkdir('images');
  eval(sprintf('print -depsc2 images/%s.eps',Name))
  fprintf(' -> save figure(%d) in images/%s.eps\n',gcf,Name);
  eval(sprintf('print -djpeg90 images/%s.jpg',Name))
  fprintf(' -> save figure(%d) in images/%s.jpg\n',gcf,Name);
  if isunix
    system(sprintf('convert -resize %d%% images/%s.eps images/%s.png',percent,Name,Name));
    fprintf(' -> save figure(%d) in images/%s.png (resize %d%%)\n',gcf,Name,percent);
  else
    eval(sprintf('print -dpng images/%s.png',Name))
    fprintf(' -> save figure(%d) in images/%s.png \n',gcf,Name);
  end
end
