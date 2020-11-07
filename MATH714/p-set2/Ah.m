function Ah_u = Ah(u, dx, dy, alpha)
% operator Ah(u) = alpha(uxx + uyy) + u
% with Homogeneous Dirichlet Boundary Conditions

  [n,m] = size(u);
   coefx = -alpha/dx^2;
   coefy = -alpha/dy^2;
   coef0 = 1 + 2*(coefx + coefy); 

   Ah_u = zeros(size(u)); 
   Ah_u(2:n-1,2:m-1) =   u(2:n-1,2:m-1)*coef0 ...
                       -(u(2:n-1,3:m) + u(2:n-1,1:m-2))*coefx ... 
                       -(u(3:n,2:m-1) + u(1:n-2,2:m-1))*coefy; 