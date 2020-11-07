for k = 1:N;
    %imposing Dirichlet boudary conditions
    u(:,1)   = bdy(:,1);
    u(:,n+2) = bdy(:,n+2);
    %imposing Neumann boundary conditions
    u(1,:)   = 2/3*( 2*u(2,:) -0.5*u(3,:));
    u(m+2,:) = 2/3*( 2*u(m+1,:) -0.5*u(m,:));

    for i = 2:m+1
        for j = 2:n+1
            %main loop
            u(i,j)  = (dx*dx*( u(i+1,j) + u(i-1,j) ) ...
                    + dy*dy*( u(i,j+1) + u(i,j-1) ) ...
                    + f(i,j))/(2*dx*dx +2*dy*dy );
        end
    end
end
