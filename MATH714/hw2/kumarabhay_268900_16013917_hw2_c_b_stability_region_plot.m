%HW2 C(b) Plotting the stability Region

clc; clear all; close all;
x_lim = 10;
y_lim = 10;
x = -x_lim:0.1:x_lim; 
y = -y_lim:0.1:y_lim; 
[X,Y] = meshgrid(x,y);

[K1, K2] = size(X);
%complex number
Z  = X + Y.*1i;
      
alpha1 = 1+Z./2 + sqrt((1+Z./2).^2-1);  % 
alpha2 = 1+Z./2 - sqrt((1+Z./2).^2-1);

% to plot regions where abs(aplha1) <=1 
Region1 = alpha1;
Region1(abs(Region1)<= 1) = 1;
Region1(abs(Region1)> 1) = 0;

% to plot regions where abs(aplha2) <=1 
Region2 = alpha2;
Region2(abs(Region2)<= 1) = 1;
Region2(abs(Region2)> 1) = 0;

% Region3 is the intersection of region1 and region2
% stability region should have both roots alpha1 and alpha2 s.t. 
% abs(aplha1) <=1 && abs(aplha2) <=1
Region3 = zeros(K1,K2);
for l = 1:1:K1
    for m = 1:1:K1
        if Region1(l,m)==1 && Region2(l,m)==1
            Region3(l,m) = 1;
        end 
    end
end

figure;
subplot(1,2,1);
surf(X,Y, Region1);
xlim([-x_lim x_lim]);
ylim([-y_lim y_lim]);
xlabel('X','fontSize',12); 
ylabel('Y','fontSize',12);
title('abs (1+Z./2 + sqrt((1+Z./2).^2-1)) <= 1 ')

subplot(1,2,2);
surf(X,Y, Region2);
xlim([-x_lim x_lim]);
ylim([-y_lim y_lim]);
xlabel('X','fontSize',12); 
ylabel('Y','fontSize',12);
title('abs (1+Z./2 - sqrt((1+Z./2).^2-1)) <= 1 ')


% subplot(2,2,3);
% surf(X,Y, Region1+Region2);
% xlim([-x_lim x_lim]);
% ylim([-y_lim y_lim]);
% xlabel('X','fontSize',12); 
% ylabel('Y','fontSize',12);
% title('absolute value')


% alpha3 = Z + sqrt((Z).^2+1);
% Region3 = abs(alpha3);
% Region3(abs(Region3)<= 1) = 1;
% Region3(abs(Region3)> 1) = 0;
figure;
surf(X,Y,Region3);
xlim([-x_lim x_lim]);
ylim([-y_lim y_lim]);
xlabel('X','fontSize',12); 
ylabel('Y','fontSize',12);
title('Stability Region (Yellow colored region)')