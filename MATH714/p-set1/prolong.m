   function Afine = prolong(Acoarse)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  prolongation routine (inverse full weighting) 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   [r,c] = size(Acoarse);
   n = r-1;
   m = c-1; 
   n2 = 2*n;
   m2 = 2*m; 

   Afine = zeros(n2+1,m2+1);

   Afine(3:2:n2-1,3:2:m2-1) =  Acoarse(2:n,2:m); 
   Afine(3:2:n2-1,2:2:m2)   = (Acoarse(2:n,1:m) + Acoarse(2:n,2:m+1))/2;
   Afine(2:2:n2  ,3:2:m2-1) = (Acoarse(1:n,2:m) + Acoarse(2:n+1,2:m))/2;
   Afine(2:2:n2  ,2:2:m2)   = (Acoarse(1:n,1:m) + Acoarse(2:n+1,2:m+1) + ...
                               Acoarse(2:n+1,1:m) + Acoarse(1:n,2:m+1) )/4;
