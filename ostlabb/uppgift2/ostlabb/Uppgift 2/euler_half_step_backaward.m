function v_old=euler_half_step_backaward(V,DT,x_new,v_new,NS,KS,KD,L)
f_old=my_force(x_new,v_new,NS,KS,KD,L);   % Initioal force calculation 
v_old=V-f_old*DT/2;                 % half backwards Euler step to get V_{-1/2}
end
