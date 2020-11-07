# Problem Set 1

This folder containt the code for the first problem set, in particular, the code used to answer part C. 

-```convergence_direct_solver.m``` contains a second-order finite difference scheme for the equation using the kronecker product. In addition, the script computes the global error using the analytical solutions, but using a direct solver (this is only to prove that the scheme converges)

-```convergence_GS_solver.m``` implements (in-situ) a Gauss-Seidel solver for the equation and it benchmarks the convergence rate of global error.

-```convergence_rate_GS_solver.m``` illustrates the convergence rate of the Gauss-Seidel iteration with respect to the grid spacing. It relies on the function GS_bc_mixed.m for the implementation of the iteration. 

-```convergence_rate_MGV_solver.m``` illustrates the convergence rate of the Multigrid V cycle with respect to the grid spacing. It relies on the function MGV_bc_mixed.m for the implementation of the mulgrid V cycle, using the Gauss-Seidel iteration (instead of an under-relaxed Jacobi iteration)

-```convergence_discontinous.m``` illustrates the convergence rate of the discretized equation when the right-hand side is not smooth. 