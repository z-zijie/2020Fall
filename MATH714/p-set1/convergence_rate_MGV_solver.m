%code for benchmark the number of iterations needed for convergence for 
% multigrid code
PP = 10;
N  = 50000; 
kk = 1;
time = zeros(PP, 2);

tol = 1e-6;

for p = 1:PP

n = 2*2^p+1; 
m = 2*2^p+1;

x = 0:1/(n-1):1 ;
y = 0:1/(m-1):1;  %in y direction you'll have m+2 points instead of m

alpha = 1;
[X,Y] = meshgrid(x, y); % grid for [0, 2pi] with (n+1)^2 points
dx = 1/(n-1);
dy = 1/(m-1);

g = zeros(size(X));

bdy = [cos(2*pi.*y.')  zeros(m,1)];

% initializing the temporal solutions
u = g;
u_0 = g;

% analitical solution
sol = cos(2*pi.*Y).*( exp(-2*pi.*X)*exp(4*pi) ...
                     -exp(2*pi.*X))/( exp(4*pi)-1 ) ;

for i = 1:N/kk
    % perfom kk steps of Gauss Seidel
    u = MGV_bc_mixed(u_0, g, bdy, dx, dy ,alpha);
    % if the difference between two consecutive guesses is less then 
    % the tolerance stop
    if(max(max(abs(u - u_0)))<tol)
        time(p,1)  = n;
        time(p,2) = i*kk;
        break;
    end
   
   u_0 = u;  
end

err = max(max(abs(u - sol)));

fprintf("Error with n = %d, is %.2e \n", n, err)

end


% Plotting the results 
figure(1); clf();
loglog(time(:,1),time(:,end),'o-', 'LineWidth', 2)
hold on; 
loglog(time(:,1), log(time(:,1)/time(1,1)).*time(1,end), 'LineStyle', '-')

ax = gca;
ax.YAxis.FontSize = 13;
ax.XAxis.FontSize = 13;

title('Number of iterations until convergence', 'FontSize', 24);
xlabel('$n_x$','Interpreter','latex', 'FontSize', 24)
ylabel('Number of iterations until convergence','Interpreter','latex', 'FontSize', 24)

lgd = legend("error", "$\mathcal{O}(log(n_x))$",'FontSize', 24,...
       'Interpreter','latex');
lgd.Location = 'northwest';
