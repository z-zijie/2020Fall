function res = residual_bc_mix(Ain,f, dx, dy, alpha)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  residual routine: Computer f - A*u
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[r,c] = size(Ain);
n = r-1;
m = c-1;
coefx = alpha/dx/dx;
coefy = alpha/dy/dy;
coef0 = 2*(coefx + coefy);

res = zeros(size(Ain));
res(2:n-1,2:m-1) = f(2:n-1,2:m-1) - ...
                   Ain(2:n-1,2:m-1)*coef0 + ...
                   (Ain(2:n-1,3:m) + Ain(2:n-1,1:m-2))*coefx + ...
                   (Ain(3:n,2:m-1) + Ain(1:n-2,2:m-1))*coefy;

% residual induced by the boundary conditions
res(1,2:m-1)   = 3/2*Ain(1,2:m-1)...
    -(2*Ain(2,2:m-1) -0.5*Ain(3,2:m-1));
res(end,2:m-1) = 3/2*Ain(end,2:m-1) ...
    -(2*Ain(end-1,2:m-1)-0.5*Ain(end-2,2:m-1));

end