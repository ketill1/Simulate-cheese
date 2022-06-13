function [E_tot,E_p,E_s,E_k]=energy_ost(M,g,L,x_old,v_old,v_new,KS,NS,NP,spring)

% potential energy
E_p=0;
for k=1:NP
E_p=E_p+M(k,k)*g*x_old(k,2);
end

% spring energi
E_s=0;
for k=1:NS
E_s=E_s+0.5*spring(k).KS*(spring(k).length-norm(x_old(spring(k).from,:)-x_old(spring(k).to,:)))^2;
end

% kinetisk energi
E_k=0;
for k=1:NP
% rember to the approx speed value
E_k=E_k+0.5*M(k,k)*norm((v_old(k,:)+v_new(k,:))./2)^2; 
end


%total energy
E_tot=E_k+E_p+E_s;

end
