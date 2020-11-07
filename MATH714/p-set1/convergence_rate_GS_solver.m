%code for benchmark the number of iterations needed for convergence

PP = 20;
N  = 50000; 
kk = 20;
time = zeros(PP, 2);

tol = 1e-6;

for p = 1:PP

n = 20*p; 
m = 20*p;

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

for i = 1:N/kk
    % perfom kk steps of Gauss Seidel
    u = GS_bc_mixed(u_0, g, bdy, kk, dx, dy ,alpha);
    
    % if the difference between two consecutive guesses is less then 
    % the tolerance stop
    if(max(max(abs(u - u_0)))<10e-10)
        time(p,1)  = n;
        time(p,2) = i*kk;
        break;
    end
   
   u_0 = u;  
end

end


% Plotting the results 
figure(1); clf();
loglog(time(:,1),time(:,end),'o-', 'LineWidth', 2)
hold on; 
loglog(time(:,1), (time(:,1)/time(1,1)).^(3/2)*time(1,end), 'LineStyle', '-')

ax = gca;
ax.YAxis.FontSize = 13;
ax.XAxis.FontSize = 13;

title('Number of iterations until convergence', 'FontSize', 24);
xlabel('$n_x$','Interpreter','latex', 'FontSize', 24)
ylabel('Number of iterations until convergence','Interpreter','latex', 'FontSize', 24)

lgd = legend("error", "$\mathcal{O}(h^{3/2})$",'FontSize', 24,...
       'Interpreter','latex');
lgd.Location = 'northwest';
