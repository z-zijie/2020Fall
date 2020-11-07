function Acoarse = restrict(Afine)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  restriction routine (full weighting)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[r,c] = size(Afine);
n = r-1;
m = c-1;
n2 = n/2;
m2 = m/2;

Acoarse = zeros(n2+1,m2+1);
Acoarse(2:n2,2:m2) =  1/4*Afine(3:2:n-1, 3:2:m-1) + ...
    1/8*Afine(2:2:n-2, 3:2:m-1) + ...
    1/8*Afine(4:2:n,   3:2:m-1) + ...
    1/8*Afine(3:2:n-1, 2:2:m-2) + ...
    1/8*Afine(3:2:n-1, 4:2:m)   + ...
    1/16*Afine(2:2:n-2,2:2:m-2) + ...
    1/16*Afine(2:2:n-2,4:2:m)   + ...
    1/16*Afine(4:2:n,  2:2:m-2) + ...
    1/16*Afine(4:2:n,  4:2:m);

%   this line alone with be simple injection
%   Acoarse(2:n2,2:m2) =  Afine(3:2:n-1, 3:2:m-1);

end
