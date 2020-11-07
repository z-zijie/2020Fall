function v = bc_mixed(u,bdy)
%----------------------------------------------
%
% imposing dirichlet boudary conditions in x and 
% homogeneus neumman boudary conditions in y
% bdy  is a n x 2 matrix with the Dirichlet BC
% at both x = 0 and x = 1
%
%----------------------------------------------
[n, m] = size(u);

v = u;

% neumann boundary conditions 
v(1,:) = 2/3*( 2*u(2,:) -0.5*u(3,:));
v(n,:) = 2/3*( 2*u(n-1,:) - 0.5*u(n-2,:));   
% dirichlet boundary conditions
v(:,1) = bdy(:,1);
v(:,m) = bdy(:,2);

