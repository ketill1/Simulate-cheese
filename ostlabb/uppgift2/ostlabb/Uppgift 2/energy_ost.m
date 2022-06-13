function [E_tot,E_p,E_s,E_k]=energy_ost(m,g,L,x_new,v_new,KS,NS,NP)

%E_p=m*g*x_new(:,2);
E_p=0;

% spring energi
E_s=0;
for k=1:NS
E_s=E_s+0.5*KS*(L-norm(x_new(k,:)-x_new(k+1,:)))^2;
end

% kinetisk energi
E_k=0;
for k=1:NP
% kom ihåg att ta medel från förra och näst hastighet
E_k=E_k+0.5*m*norm(v_new(k,:))^2; 
end

%total energy
E_tot=E_k+E_p+E_s;

end
