f = @(x)(exp(-400*(x-0.5).^2));
Nref = 100000 ;
xref = 0:1/Nref:1;

N = 98;
x = 0:1/N:1;
y = f(x);

yint = interp1(x,y,xref);

max(max(abs(yint - f(xref) )))

plot(xref, abs(yint - f(xref)))