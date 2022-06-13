function F=my_force(x_new,v_new,NS,KS,KD,L)

for k=1:NS
r=x_new(k,:)-x_new(k+1,:); % distans mellan partiklar
r_prick=v_new(k,:)-v_new(k+1,:); % hastighetskillnad mellan partiklar
end

F=-(KS*(norm(r)-L)+KD*(dot(r_prick,r))/norm(r))*r/norm(r);
F=[F;-F];
end