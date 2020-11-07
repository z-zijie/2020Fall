% Script to benchmark the convergence of the numerical method using an 
% GS iteration

PP = 4;
Nit  = 50000; 
err = zeros(PP, Nit);
h = zeros(PP,1);

for p = 1:PP
    
    n = 10*2^(p-1);
    m = 20*2^(p-1);
    
    dx = 1/(n+1);
    dy = 1/(m+1);
    
    h(p) = dx;
    
    x = 0 :dx:1;
    y = 0 :dy:1;
    
    [X, Y] = meshgrid(x,y);
    
    bdy         = cos(2*pi.*Y);
    bdy(:,n+2)  = 0;
    
    f = zeros(size(X));
    u = zeros(size(X));
    
    sol = cos(2*pi.*Y).*( exp(-2*pi.*X)*exp(4*pi) ...
                         -exp(2*pi.*X))/( exp(4*pi)-1 ) ;
    
    for k = 1:Nit
        u(:,1)   = bdy(:,1);
        u(:,n+2) = bdy(:,n+2);
        u(1,:)   = 2/3*( 2*u(2,:) -0.5*u(3,:));
        u(m+2,:) = 2/3*( 2*u(m+1,:) -0.5*u(m,:));
        
        for i = 2:m+1
            for j = 2:n+1
                u(i,j) = (dx*dx*( u(i+1,j) + u(i-1,j) ) ...
                    + dy*dy*( u(i,j+1) + u(i,j-1) ) ...
                    + f(i,j))/(2*dx*dx +2*dy*dy );
            end
        end
        err(p,k) = max(max(abs(u-sol)))/max(max(abs(sol)));
    end
    

% figure(1);
% surf(X,Y,u);
% 
% figure(2);
% surf(X,Y, u-sol);

end


% Plotting the results 
figure(1); clf();
loglog(h,err(:,end),'o-', 'LineWidth', 2)
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

% Plotting the results 
figure(2); clf();
loglog([1:Nit],err,'o-', 'LineWidth', 2)

ax = gca;
ax.YAxis.FontSize = 13;
ax.XAxis.FontSize = 13;

title('Error', 'FontSize', 24);
xlabel('$n_{it}$: number of iterations','Interpreter','latex', 'FontSize', 24)
ylabel('relative $\ell^2$ error','Interpreter','latex', 'FontSize', 24)


lgd = legend("$N_x = 10$", "$N_x = 20$","$N_x = 40$", "$N_x = 80$",...
            'FontSize', 24,...
            'Interpreter','latex');
lgd.Location = 'northeast';