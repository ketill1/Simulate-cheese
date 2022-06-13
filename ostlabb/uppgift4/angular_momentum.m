function [length_spring,angular_frequency,H]=angular_momentum...
    (M,NP,x_old,v_old,spring,NS,v_new,m_tot) 
H=0;
xmid=0;
for k=1:NP
xmid = xmid+M(k,k)*v_new(k,:)/m_tot;
end
for k=1:NP
    xrel = x_old(k,:) - xmid;
H=H+M(k,k)*(xrel(1)*v_old(k,2)-xrel(2)*v_old(k,1));
end

I=0;
for k=1:NP
I=I+M(k,k)*norm(xmid-x_old(k,:))^2;
end

% Length of springs
length_spring=0;
for k=1:NS
length_spring=length_spring+norm(x_old(spring(k).from,:)-x_old(spring(k).to,:));
end

angular_frequency=H/I;
end