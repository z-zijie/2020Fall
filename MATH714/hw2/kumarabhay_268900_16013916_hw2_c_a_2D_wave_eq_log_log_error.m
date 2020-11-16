%HW2-C(a): 2D wave equation
%Plots log-log plot of the error vs. the grid spacing ?x
%Simulate the wave equation over time, uncomment the last code block


clc; clear all; close all;

%To store values for different h or N
inf_norm_error = [];
grid_size = [];
N_value = [];

%Time Limit
T = 1;

%Finest Grid solution
finest = 9;     % change to 10 for the plot in pdf
dxf = 1/(2^finest);  
dyf = dxf;
sigma = 1/sqrt(2); %gamma = 1/sqrt(2); %CFL Stability Condition
dtf = dxf*0.5;  % dtf/dcf < sigma i.e dtf/dxf < 1/sqrt(2) CFL condition

%time discretization
tf = 0:dtf:T; 
%space discretization
xf = 0:dxf:1; 
yf = 0:dyf:1; 

%Initial conditions
uf = zeros(length(xf),length(yf),length(tf));
uf(:,:,1) = 0;
uf(:,:,2) = dtf*(transpose(exp(-400.*(xf-0.5).^2))*(exp(-400.*(yf-0.5).^2)));

%Two-step method 
%2D WAVE EQUATION utt = c^2(uxx+uyy) 
%with initial condition  u(x,y,0) = sin(p*pi*x)*sin(q*pi*y), 0<x<1 0<y<1
% and boundary conditions u(0,y,t) = u(1,y,t)= u(x,0,t)= u(x,1,t) = 0 t>0
%Time update
for n=3:length(tf)-1 
    %space update
    for i=2:length(xf)-1 
        for j=2:length(yf)-1
            uf(i,j,n+1)= (dtf/dxf)^2*(uf(i+1,j,n)-4*uf(i,j,n)+uf(i-1,j,n)+uf(i,j+1,n)+uf(i,j-1,n))...
                        + 2*uf(i,j,n) - uf(i,j,n-1);
        end
    end
end

%2D WAVE EQUATION utt = c^2(uxx+uyy) 
%with initial condition  u(x,y,0) = sin(p*pi*x)*sin(q*pi*y), 0<x<1 0<y<1
% and boundary conditions u(0,y,t) = u(1,y,t)= u(x,0,t)= u(x,1,t) = 0 t>0
% Coarse grid solution to plot error vs h

for coarse_grid_ind= 5:finest-1
    N_val = 2^(coarse_grid_ind);
    downsample = 2^(finest-coarse_grid_ind);
    dx = 1/N_val;
    dy = dx;
    dt = dtf; %dx * 1/sqrt(2);

    %time discretization
    t = 0:dt:T; 

    %space discretization
    x = 0:dx:1; 
    y = 0:dy:1; 

    u = zeros(length(x),length(y),length(t));
    %homogeneous Dirichlet boundary condition u(x,y,0) = 0  
    u(1,:,:) = 0; u(:,1,:) = 0; u(length(x),:,:) = 0; u(:,length(y),:) = 0;

    u(:,:,1) = 0;
    u(:,:,2) = dt*(transpose(exp(-400.*(x-0.5).^2))*(exp(-400.*(y-0.5).^2)));

    % figure; [X,Y] = meshgrid(x,y); surf(X,Y, u(:,:,2)); 
    % title('boundary condition');


    for n=3:length(t)-1
        for i=2:length(x)-1
            for j=2:length(y)-1
                u(i,j,n+1)= (dt/dx)^2*(u(i+1,j,n)-4*u(i,j,n)+u(i-1,j,n)+u(i,j+1,n)+u(i,j-1,n))...
                            + 2*u(i,j,n) - u(i,j,n-1);
            end
        end
    end
    
    %Absolute error
    ufine = uf(1:downsample:end, 1:downsample:end,:);
    inf_norm_error(end+1) = max(max(max(abs(ufine-u))));
    grid_size(end+1) = dx;
    N_value(end+1) = N_val;
    
end


%convergence of the numerical scheme in a log-log plot of the maximum norm of the error vs. h
figure; clf;
plot(log(grid_size),log(inf_norm_error));
xlabel('log of h values','fontSize',12);
ylabel('log of error','fontSize',12);
grid on
title('convergence of the numerical scheme in a log-log plot of the norm of the error vs. h')


[X,Y] = meshgrid(x,y);
E= ufine-u;  %Error in finest grid and one level coarse grid


%To visualize the wave, please uncomment following block.

% for j=1:length(t)
%        subplot(2,1,1)
%        colormap(cool);
%        p1 = surf(X,Y,u(:,:,j)); 
%        title(sprintf('2D wave equation at t = %1.2f',t(j)),'Fontsize',11);
%        xlabel('x','Fontsize',11); ylabel('y','Fontsize',11);
%        zlabel(sprintf('u(x,y,t = %1.2f)',t(j)),'Fontsize',11);
%        %axis ([0 1 0 1 -1 1]);
%        
%        subplot(2,1,2)
%        p2 = surf(X,Y,E(:,:,j)); 
%        title(sprintf('Absolute error at t = %1.2f',t(j)),'Fontsize',11);
%        xlabel('x','Fontsize',11); ylabel('y','Fontsize',11);
%        zlabel(sprintf('E(x,y,t = %1.2f)',t(j)),'Fontsize',11);
%        %axis ([0 1 0 1 0 max_e]);
%        pause(0.001);
%        hold on; 
%        
%        if(j~=length(t))
%        delete(p1);
%        delete(p2);
%        end
% end
