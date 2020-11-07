function Aout = MGV_bc_mixed(Ain,f,bdy, dx, dy, alpha)
%------------------------------------------------------------------
% geometric multigrid V-cycle
%
% (recursive definition)  solving -alpha( uxx + uyy )  = f
% (homogeneous Dirichlet boundary conditions in x
%  Neumann homogenous boundary conditions in y)
% (dimension N has to be of the form 2^k + 1)
%
% Ain:  guessed solution (n x m)-matrix
% f:    right-hand side (n x m)-matrix
%
%------------------------------------------------------------------

n = size(f,1);
m = size(f,2);
[k, l] = size(bdy);

if(n~=k || l~=2)
    fprintf('dimention of the boundary condition mismatch');
end

% if we are at the coarsest level
if ((n==5)|(m==5))
    Aout = GS_bc_mixed(Ain,f,bdy,10,  dx, dy, alpha);
else
    % otherwise
    
    % relax 10 times (pre-smoothing)
    Asmooth = GS_bc_mixed(Ain,f,bdy,10, dx, dy, alpha);
    
    % compute the residual
    res  = residual_bc_mix(Asmooth,f, dx, dy, alpha);
    
    % restrict the residual to the next-coarser grid
    res2 = restrict(res);
    
    %     solve the error equation on the next-coarser grid by MGV
    err = MGV_bc_mixed(zeros(size(res2)),res2, zeros(size(res2,1),2), 2*dx, 2*dy, alpha);
    
    %     add the prolongated error to the solution
    Ain = Asmooth + prolong(err);
    
    %     relax 10 times (post-smoothing)
    Aout = GS_bc_mixed(Ain,f,bdy,10, dx, dy, alpha);
    
end

