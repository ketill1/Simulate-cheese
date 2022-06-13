function F=my_force(x_old,v_old,NS,KS,KD,L)

for k=1:NS
r=x_old(k,:)-x_old(k+1,:); % distans mellan partiklar
r_prick=v_old(k,:)-v_old(k+1,:); % hastighetskillnad mellan partiklar
end

F=-(KS*(norm(r)-L)+KD*(dot(r_prick,r))/norm(r))*r/norm(r);
F=[F;-F];
end