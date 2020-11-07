% Script to benchmark the convergence of the numerical method

% number of refinements
Np = 7;
% arrays to store the error and mesh size
err = zeros(Np,1);
h = zeros(Np,1);

for idxRef = 1:Np

    p = 2^idxRef;
    n = 10*p; 
    m = 10*p;

    dx = 1/(n+1);
    dy = 1/(m+1);

    x = 0:dx:1;
    y = 0:dy:1;

    [X Y] = meshgrid(x,y) ;
    
    % Building the 1D Dirichelet minus Laplacian matrix
    e = ones(n,1);
    Asp = spdiags([-e 2*e -e], -1:1, n, n);
  
    % Building the 1D Neumann minus Laplacian matrix
    e = ones(m+2,1);
    Bsp = spdiags([-e 2*e -e], -1:1, m+2, m+2);
    Bsp(1,1:3) = [1.5 -2 0.5 ]*dy;
    Bsp(end,end-2:end) = [ 0.5 -2 1.5 ]*dy;
    
    % creating the identities (here carefull with the 
    % boundaries)
    I_A = speye(m+2,m+2);   I_A(1,1) = 0;   I_A(end,end) = 0;
    I_B = speye(n,n);
    
    % assembling the 2D minus Laplacian
    Delta = kron(Asp/dx^2,I_A) + kron(I_B,Bsp/dy^2);
    
    % writing the source term
    f = cos(2*pi*y);    f(1) = 0;   f(end) = 0;
    e_1 = zeros(n,1);   e_1(1) = 1;
    F = kron(e_1, f).';
    f = F(:)/dx^2;
    
    % solving the system using a sparse solver for reference
    u_dir = Delta\f;

    % sampling the analytical solution 
    sol = cos(2*pi.*Y(:,2:end-1)).*(exp(-2*pi.*X(:,2:end-1))*exp(4*pi)...
        - exp(2*pi.*X(:,2:end-1)))/( exp(4*pi)-1 ) ;
    
    % computing the relative l^2 error
    err(idxRef) = norm(sol(:) - u_dir(:))/norm(sol(:));
    % saving the step size
    h(idxRef) = dx;

end

% Plotting the results 
figure(1); clf();
loglog(h,err,'o-', 'LineWidth', 2)
hold on; 
loglog(h, h.^2, 'LineStyle', '-')

ax = gca;
ax.YAxis.FontSize = 13;
ax.XAxis.FontSize = 13;

title('Error', 'FontSize', 24);
xlabel('$h$','Interpreter','latex', 'FontSize', 24)
ylabel('relative $\ell^2$ error','Interpreter','latex', 'FontSize', 24)


lgd = legend("error", "$\mathcal{O}(h^2)$",'FontSize', 24,...
       'Interpreter','latex');
lgd.Location = 'northwest';