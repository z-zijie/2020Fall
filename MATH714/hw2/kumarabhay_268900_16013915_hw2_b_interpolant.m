% HW2 Part-B Uniform norm of difference between function value and interpolant
%x: [0,1]
%Sample it on a grid x_j =j h  with h=1/N and 0 <= j <= N,for some N to be determined
clc; clear all; close all;

approxm_error_norm = [];
N_values = [];
for N = 10:1:110

    h=1/N; %grid step size
    x = 0:h:1; %grid
    f = exp(-400.*(x-0.5).^2); %actual function value at grid points

    % HAVE TESTED on finer grids h/10 and h/100, and it gives same N=100
    %Fine grid xq_f
    xq_f = 0:h/10:1; 
    f_intp1 = interp1(x,f,xq_f); %interpolant value on finer grid points xq_f
    
    %actual value of f on value on finer grid points xq_f
    f_fine_grid = exp(-400.*(xq_f-0.5).^2); 
    
    %uniform  norm of difference
    f_difference1 = f_fine_grid-f_intp1;
    diff_unif_norm1 = max(abs(f_difference1));
    %disp("uniform norm error for N= "+N+ " = " +  diff_unif_norm);
    if (diff_unif_norm1 < 0.1)
        approxm_error_norm(end+1) = diff_unif_norm1;
        N_values(end+1) = N;
    end
    if (diff_unif_norm1 < 0.01)
        disp("uniform norm error for N= "+N+ " = " +  diff_unif_norm1 +" i.e. less than 0.01");
       % break
    end
end

% Check for each value of N 
% for N = 10:1:110
%     h=1/N; %grid step size
%     x = 0:h:1;  %grid
%     f = exp(-400.*(x-0.5).^2); %actual function value at grid points
%     xq = 0:h/2:1; 
%     f_intp = interp1(x,f,xq); 
%     max_deviation_values = f_intp(2:2:end-1);
%     x_intermediate = xq(2:2:end-1);
%     f_intermediate = exp(-400.*(x_intermediate-0.5).^2);
%     f_difference = max_deviation_values-f_intermediate;
%     diff_unif_norm = max(abs(f_difference));
%     if (diff_unif_norm < 0.01)
%         disp("uniform norm error for N= "+N+ " = " +  diff_unif_norm +" i.e. less than 0.01");
%         break
%     end
% end
figure; plot(N_values,approxm_error_norm,'o'); 
title('Uniform norm of Difference of f from its linear interpolant vs N')
ylabel('Uniform norm of interpolant difference from actual function value'); xlabel('N');

figure; plot(x,f,'o',xq_f,f_intp1,':.'); 
xlim([0 1]); xlabel('x'); ylabel ('Interpolant values'); 
title('Linear Interpolation on fine grid');

figure;
subplot(3,1,1)
plot(xq_f, f_difference1); xlabel('x'); ylabel('f');
title('Approxm error at very fine grid points');

subplot(3,1,2)
f_derivative = exp(-400.*(xq_f-0.5).^2).*(-800*(xq_f-0.5));
plot(xq_f, f_derivative); xlabel('x');  ylabel('f_x');
title('Derivative of f (f_x) at fine grid points');

subplot(3,1,3)
f_2nd_derivative = (-800)*(exp(-400.*(xq_f-0.5).^2).*((-800)*(xq_f-0.5).^2 + 1));
plot(xq_f, f_2nd_derivative);xlabel('x'); ylabel('f_{xx}');
title('Double Derivative of f (f_{xx}) at fine grid points');
