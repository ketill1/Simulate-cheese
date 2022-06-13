function v_old=euler_half_step_backaward(V,DT,NP)
f_old=0.5*(0.5-rand(NP,2))-0.1*V;   % Initioal force calculation 
v_old=V-f_old*DT/2;                 % half backwards Euler step to get V_{-1/2}
end
