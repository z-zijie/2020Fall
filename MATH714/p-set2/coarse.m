function Acoarse = coarse(Afine) 

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

   % creating 
   N_2 = 1:2:r;
   M_2 = 1:2:c;
   Acoarse = zeros(n2+1,m2+1); 
   Acoarse = Afine(N_2, M_2);

%   this line alone with be simple injection
%   Acoarse(2:n2,2:m2) =  Afine(3:2:n-1, 3:2:m-1);
