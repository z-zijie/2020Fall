function Acoarse = restrict_bc(Afine)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  restriction routine for the Dirichelt Boundary conditions
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[r,c] = size(Afine);
n = r-1;
% c should be 2
n2 = n/2;

Acoarse = zeros(n2+1,2);
Acoarse(2:n2,2) =  1/2*Afine(3:2:n-1, 3:2:m-1) + ...
                   1/4*Afine(2:2:n-2, 3:2:m-1) + ...
                   1/4*Afine(4:2:n,   3:2:m-1) ;

%   this line alone with be simple injection
%   Acoarse(2:n2,2:m2) =  Afine(3:2:n-1, 3:2:m-1);

end