function Test=valid_StiffElas()
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
i=1;
Test(i).u={@(x,y) x - 2.*y, @(x,y) x + y};
Test(i).cu={'x - 2*y','x + y'};
Test(i).v={@(x,y) x + 2.*y, @(x,y) 2.*x - y};
Test(i).cv={'x + 2*y','2*x - y'};
Test(i).Mass=-5/12;
Test(i).Stiff=-8;
Test(i).lambda=1;
Test(i).mu=2;
Test(i).degree=2;
i=2;
Test(i).u={@(x,y) x.^2 - 2.*x.*y, @(x,y) y.^2 + x};
Test(i).cu={'x^2 - 2*x*y','y^2 + x'};
Test(i).v={@(x,y) x.^2 + 2.*y.^2, @(x,y) 2.*x.^2 - x.*y};
Test(i).cv={'x^2 + 2*y^2','2*x^2 - x*y'};
Test(i).Mass=37/360;
Test(i).Stiff=-4/3;
Test(i).lambda=1;
Test(i).mu=2;
Test(i).degree=2;
i=3;
Test(i).u={@(x,y) x.^2 - y.^2, @(x,y) x.^3 - y.^3};
Test(i).cu={'x^2 - y^2','x^3 - y^3'};
Test(i).v={@(x,y) 2.*y.^3 + x, @(x,y) 2.*x.^2 - x.*y};
Test(i).cv={'2*y^3 + x','2*x^2 - x*y'};
Test(i).Mass=1/12;
Test(i).Stiff=3;
Test(i).lambda=1;
Test(i).mu=1;
Test(i).degree=2;
i=4;
Test(i).u={@(x,y) x.^2 - y.^4, @(x,y) x.^4 - y.^3};
Test(i).cu={'x^2 - y^4','x^4 - y^3'};
Test(i).v={@(x,y) x.^2.*y.^2 + 2.*y.^3, @(x,y) 2.*x.^2 - x.*y};
Test(i).cv={'x^2*y^2 + 2*y^3','2*x^2 - x*y'};
Test(i).Mass=1/14;
Test(i).Stiff=5/9;
Test(i).lambda=3;
Test(i).mu=1;
Test(i).degree=2;
i=5;
Test(i).u={@(x,y) x.^3.*y.^2 - x.^2 - y.^4, @(x,y) x.^4 - 2.*y.^5 - y.^3};
Test(i).cu={'x^3*y^2 - x^2 - y^4','x^4 - 2*y^5 - y^3'};
Test(i).v={@(x,y) x.^2.*y.^3 + 2.*y.^3, @(x,y) -x.^4.*y + 2.*x.^2};
Test(i).cv={'x^2*y^3 + 2*y^3','-x^4*y + 2*x^2'};
Test(i).Mass=-1927/4200;
Test(i).Stiff=101/35;
Test(i).lambda=1;
Test(i).mu=3;
Test(i).degree=2;
i=6;
Test(i).u={@(x,y) x.^6 + x.^3.*y.^2 - x.^2 - y.^4, @(x,y) -2.*x.*y.^5 + x.^5 - y.^3};
Test(i).cu={'x^6 + x^3*y^2 - x^2 - y^4','-2*x*y^5 + x^5 - y^3'};
Test(i).v={@(x,y) x.^3.*y.^3 + 2.*y.^3, @(x,y) -x.^4.*y.^2 + 2.*x.^2};
Test(i).cv={'x^3*y^3 + 2*y^3','-x^4*y^2 + 2*x^2'};
Test(i).Mass=-367/1120;
Test(i).Stiff=1073/504;
Test(i).lambda=1;
Test(i).mu=2;
Test(i).degree=2;