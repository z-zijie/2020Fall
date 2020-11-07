function x = GS_bc_mixed(u0, b, bdy, n_it, dx, dy ,alpha)

%----------------------------------
% solves -alpha( uxx + uyy) = f equation on
% unit square using Gauss-Seidel with dirichlent boundary condition in x
% and neumann boundary conditions in y
%----------------------------------

% resolution
n = size(b,1);   %number of grid points in X
m = size(b,2);   %number of grid points in y

[k, l] = size(bdy);

if(n~=k || l~=2)
    fprintf('dimention of the boundary condition mismatch');
end


% coefficients for Poisson equation
coefx = alpha/dx/dx;
coefy = alpha/dy/dy;
coef0 = 2*(coefx + coefy);

% initialization and fixing boudary conditions
u = bc_mixed(u0,bdy);

% iteration
for k=1:n_it
    % iterate in i
    for i=2:n-1
        % iterate in j
        for j=2:m-1
            u(i,j) = (  coefx*(u(i+1,j) + u(i-1,j)) ...
                      + coefy*(u(i,j+1) + u(i,j-1)) ...
                      + b(i,j))/coef0;
        end
    end
    u = bc_mixed(u,bdy);
end

% final solution
x = u;
