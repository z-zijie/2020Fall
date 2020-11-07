uv = {};

uv{1} =  wave_solution(33, 1 , 0.01);
uv{2} =  wave_solution(65, 1 , 0.005);
uv{3} =  wave_solution(129, 1 , 0.0025);
uv{4} =  wave_solution(257, 1 , 0.00125);
uv{5} =  wave_solution(513, 1 , 0.000625);
uv{6} =  wave_solution(1025, 1 , 0.0003125);
uv{7} =  wave_solution(2049, 1 , 0.00015625);

err = zeros(6,1);
ucoarse = coarse(uv{7});

for i = 6:-1:1
    err(i) =  max(max(abs(uv{i} - ucoarse)));
    ucoarse = coarse(ucoarse);
end

N = 2.^[5:10] +1;

loglog(N, err);
hold on; 
loglog(N, N.^(-2)/N(1)*err(1));

