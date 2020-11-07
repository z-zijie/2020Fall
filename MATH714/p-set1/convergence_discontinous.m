%testing the mgv for bdy = sign(cos(2*pi.*Y));
%% compute the "exact" solution using MGV in a very fin grid
n = 2^10+1;    %dimention of the grid 
m = 2^10+1; 
x = 0:1/(n-1):1 ;
y = 0: 1/(m-1) : 1;  %in y direction you'll have m+2 points instead of m

N = 3000;   %number of iterations

alpha = 1;
[X,Y] = meshgrid(x, y); % grid for [0, 2pi] with (n+1)^2 points
dx = 1/(n-1);
dy = 1/(m-1);

g = zeros(size(X));

bdy = [sign(cos(2*pi.*y.')) zeros(m,1)];

%u = modGSmix(g,g ,bdy , N , dy , dx , alpha);
ktimes = 10;
u1 = ones(size(g));
for i= 1:ktimes
  u1 = MGV_bc_mixed(u1, g ,bdy,  dy, dx ,alpha);
end

sol = {};
sol{1} = u1;

for k = 2:8
    sol{k} = coarse(sol{k-1});
end


%% compute each approximation
p_fin = 9; % final power
p_in = 4;  % initial power
err = zeros(p_fin-p_in+1,3);

for p = p_in:p_fin
% number of discretization points
n = 2^p+1; 
m = 2^p+1;

% grid spacing
dx = 1/(n-1);
dy = 1/(m-1);

x = 0:dx:1;
y = 0:dy:1;

[X Y] = meshgrid(x,y) ;

bdy = [sign(cos(2*pi.*y.')) zeros(m,1)];

g = zeros(size(X));
u = zeros(size(g));

for i= 1:ktimes
  u = MGV_bc_mixed(u, g ,bdy,  dy, dx ,alpha);
end


% figure(1);
% u_err = u-sol{7+p_in-p};
% surf(u_err(2:end-1, 2:end) );

err(p-p_in+1,1) = dx;
err(p-p_in+1,2) = max(max(abs(u_err(2:end-1, 2:end))));
err(p-p_in+1,3) = sqrt(sum(sum(dx*dy*u_err(2:end-1, 2:end).^2)));

end

%% Plotting the results 
figure(1); clf();
loglog(err(:,1),err(:,2),'o-', 'LineWidth', 2)
hold on; 
loglog(err(:,1),err(:,3),'o-', 'LineWidth', 2)
loglog(err(:,1), (err(:,1)/err(1,1)).*err(1,3), 'LineStyle', '-', 'LineWidth', 2)

ax = gca;
ax.YAxis.FontSize = 13;
ax.XAxis.FontSize = 13;

title('Error', 'FontSize', 24);
xlabel('$h$','Interpreter','latex', 'FontSize', 24)
ylabel('Error','Interpreter','latex', 'FontSize', 24)

lgd = legend("$\ell^{\infty}$ error","$\ell^{2}$ error", "$\mathcal{O}(h)$",'FontSize', 24,...
       'Interpreter','latex');
lgd.Location = 'northwest';
