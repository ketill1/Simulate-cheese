close all
clearvars -except answers

prompt = {'Nr','Nc','Nz','L=1','hight L','KS','KD','g','vx0','vy0','Hy','Rg','Rb','E_step','time_step','step_size','d_between_g','NGc','NGr','vz0'};
dltitle = 'Input';
dims = [0.6 50];
if exist('answer','var')
    definput=answer;
else
    definput={'2','2','3','1','2','1000','5','10','0','0','0','1','0.2','10','2','0.002','1','5','5','0'};
end
answer = inputdlg(prompt,'----Cheeze Simulator----',dims,definput);


Nr=str2double(answer{1});
Nc=str2double(answer{2});
Nz=str2double(answer{3});
L=str2double(answer{4});
hight=str2double(answer{5});
KS=str2double(answer{6});
KD=str2double(answer{7});
g=str2double(answer{8});
vx0=str2double(answer{9});
vy0=str2double(answer{10});
Hy=str2double(answer{11});
Rg=str2double(answer{12});
Rb=str2double(answer{13});
E_step=str2double(answer{14});
time_step=str2double(answer{15});
step_size=str2double(answer{16});
d_between_g=str2double(answer{17});
NGc=str2double(answer{18});
NGr=str2double(answer{19});
vz0=str2double(answer{20});

t=0:step_size:time_step;
NP=Nr*Nc*Nz;
L_digonal=sqrt(L^2+L^2);
L_diagonal_z=sqrt(3*L^2);
nr_layer=Nc*Nr;
NG=NGc*NGr;

%Particles
particle_number=1;
for z=1:Nz
    for r=1:Nr
        for c=1:Nc
            X(particle_number,1)=c*L;
            X(particle_number,2)=r*L+hight;
            X(particle_number,3)=z*L+hight;
            V(particle_number,1)=vx0;
            V(particle_number,2)=vy0;
            V(particle_number,3)=vz0;
            F(particle_number,1)=0;
            F(particle_number,2)=0;
            F(particle_number,3)=0;
            particle_number=particle_number+1;
        end
    end
end

%Ground particles
ground_nummer=1;
for r=1:NGr
    for c=1:NGc
        G(ground_nummer,1)=c*d_between_g;
        G(ground_nummer,2)=r*d_between_g;
        G(ground_nummer,3)=0;
        ground_nummer=ground_nummer+1;
    end
end

spring_number=1;
layer=1;

for a=1:NP
    particle_number=a;
    
    if mod(a,Nc)~=0
        spring(spring_number).from=particle_number; % (1,1,1)-(2,1,1) -
        spring(spring_number).to=particle_number+1;
        spring(spring_number).length=L;
        spring(spring_number).KS=KS;
        spring(spring_number).KD=KD;
        spring_number=spring_number+1;
    end
    if a<nr_layer*layer- Nc+1
        spring(spring_number).from=particle_number; % (1,1,1)-(1,2,1) |
        spring(spring_number).to=particle_number+Nc;
        spring(spring_number).length=L;
        spring(spring_number).KS=KS;
        spring(spring_number).KD=KD;
        spring_number=spring_number+1;
    end
    if mod(a,Nc)~=0 && a<nr_layer*layer-Nc+1
        spring(spring_number).from=particle_number; % (1,1,1)-(1,1,2) /
        spring(spring_number).to=particle_number+Nc+1;
        spring(spring_number).length=L_digonal;
        spring(spring_number).KS=KS;
        spring(spring_number).KD=KD;
        spring_number=spring_number+1;
    end
    if mod(a,Nc)~=0 && a<nr_layer*layer-Nc+1
        spring(spring_number).from=particle_number+1; % (1,1,1)-(1,2,1) \
        spring(spring_number).to=particle_number+Nc;
        spring(spring_number).length=L_digonal;
        spring(spring_number).KS=KS;
        spring(spring_number).KD=KD;
        spring_number=spring_number+1;
    end
    if layer<Nz
        spring(spring_number).from=particle_number; % (2,1,1)-(1,2,1) | upp
        spring(spring_number).to=particle_number+nr_layer;
        spring(spring_number).length=L;
        spring(spring_number).KS=KS;
        spring(spring_number).KD=KD;
        spring_number=spring_number+1;
    end
    if mod(a,Nc)~=0 && layer< Nz
        spring(spring_number).from=particle_number; % (2,1,1)-(1,2,1) / upp
        spring(spring_number).to=particle_number+nr_layer+1;
        spring(spring_number).length=L_digonal;
        spring(spring_number).KS=KS;
        spring(spring_number).KD=KD;
        spring_number=spring_number+1;
    end
    if  a<nr_layer*layer-Nc+1 && layer< Nz
        spring(spring_number).from=particle_number; % (1,1,1)-(2,1,2) \ upp
        spring(spring_number).to=particle_number+Nc+nr_layer;
        spring(spring_number).length=L_digonal;
        spring(spring_number).KS=KS;
        spring(spring_number).KD=KD;
        spring_number=spring_number+1;
    end
    if mod(a,Nc)~=0 && layer< Nz
        spring(spring_number).from=particle_number+1;
        spring(spring_number).to=particle_number+nr_layer;
        spring(spring_number).length=L_digonal;
        spring(spring_number).KS=KS;
        spring(spring_number).KD=KD;
        spring_number=spring_number+1;
    end
    if  a<nr_layer*layer-Nc+1 && layer< Nz
        spring(spring_number).from=particle_number+Nc;
        spring(spring_number).to=particle_number+nr_layer;
        spring(spring_number).length=L_digonal;
        spring(spring_number).KS=KS;
        spring(spring_number).KD=KD;
        spring_number=spring_number+1;
    end
    % Diagonal, diagonal
    if mod(a,Nc)~=0 && a<nr_layer*layer-Nc+1 && layer< Nz
        spring(spring_number).from=particle_number;
        spring(spring_number).to=particle_number+nr_layer+Nc+1;
        spring(spring_number).length=L_diagonal_z;
        spring(spring_number).KS=KS;
        spring(spring_number).KD=KD;
        spring_number=spring_number+1;
    end
    if mod(a,Nc)~=0 && a<nr_layer*layer-Nc && layer< Nz
        spring(spring_number).from=particle_number+nr_layer;
        spring(spring_number).to=particle_number+Nc+1;
        spring(spring_number).length=L_diagonal_z;
        spring(spring_number).KS=KS;
        spring(spring_number).KD=KD;
        spring_number=spring_number+1;
    end
    if mod(a,Nc)~=0 && a<nr_layer*layer-Nc+1 && layer< Nz
        spring(spring_number).from=particle_number+1;
        spring(spring_number).to=particle_number+nr_layer+Nc;
        spring(spring_number).length=L_diagonal_z;
        spring(spring_number).KS=KS;
        spring(spring_number).KD=KD;
        spring_number=spring_number+1;
    end
    if mod(a,Nc)~=0 && a<nr_layer*layer-Nc+1 && layer< Nz
        spring(spring_number).from=particle_number+Nc;
        spring(spring_number).to=particle_number+nr_layer+1;
        spring(spring_number).length=L_diagonal_z;
        spring(spring_number).KS=KS;
        spring(spring_number).KD=KD;
        spring_number=spring_number+1;
    end
    if mod(particle_number,nr_layer)==0
    layer=layer+1;
    end
end
NS=spring_number-1;

% Mass diagonal matrix
m=ones(1,NP);
M=diag(m);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Utritning av partiklar
fig1 = figure(1);
fig1.WindowState = 'maximized';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Instaellningar for grafik-fonstret
daspect([1,1,1]);   % Skalar axlarna lika
axis([G(1,1)-1,G(end,1)+1,G(1,2)-1,G(end,2)+1,G(1,3)-1,X(end,3)+1]);    % Axlarnas intervall
view(3)
hold on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Drawing of particles
plot_3d_particles=gobjects(1,NP);
for k=1:NP
plot_3d_particles(k)=plot3(X(k,1),X(k,2),X(k,3),'o');
end

% Drawing of springs
plot_3d_lines=gobjects(1,NS);
for k=1:NS
    plot_3d_lines(k)=plot3([X(spring(k).from,1),X(spring(k).to,1)],...
        [X(spring(k).from,2),X(spring(k).to,2)],...
        [X(spring(k).from,3),X(spring(k).to,3)]); 
end

% Drawing of ground
ground=gobjects(1,NG);
[x,y,z]=sphere;
scale=1;
x=x*scale;
y=y*scale;
z=z*scale;
for k=1:NG
    ground(k)=surf(x+G(k,1),y+G(k,2),z+G(k,3));
    hold on
end

% Huvudslingan
N=length(t);
% Initial conditions
x_old=X;

for k=1:NS
    % distans mellan partiklar
    r=x_old(spring(k).from,:)-x_old(spring(k).to,:);
    % hastighetskillnad mellan partiklar
    r_prick=V(spring(k).from,:)-V(spring(k).to,:);

    % Initial force calculation
    f=-(KS*(norm(r)-spring(k).length)+KD*(dot(r_prick,r))/norm(r))*r/norm(r);
    F(spring(k).from,:)=F(spring(k).from,:)+f;
    F(spring(k).to,:)=F(spring(k).to,:)-f;
end
F(:,3)=F(:,3)-g*diag(M);
% half backwards Euler step to get V_{-1/2}
v_old=V-F*step_size/2;

E_tot=zeros(1,E_step);
E_p=zeros(1,E_step);
E_s=zeros(1,E_step);
E_k=zeros(1,E_step);
length=zeros(1,E_step);
omega=zeros(1,E_step);
j=1;
VCM=zeros(N,3);
m_tot=sum(diag(M));

for n=1:N % Main loop
    % Updatera positioner
    % Force calculation (may involve x_old and v_old)
    F=zeros(NP,3);
    for k=1:NS

        % distans mellan partiklar
        r=x_old(spring(k).from,:)-x_old(spring(k).to,:);
        % hastighetskillnad mellan partiklar
        r_prick=v_old(spring(k).from,:)-v_old(spring(k).to,:);
        f=-(KS*(norm(r)-spring(k).length)+KD*(dot(r_prick,r))/norm(r))*r/norm(r);

        F(spring(k).from,:)=F(spring(k).from,:)+f;
        F(spring(k).to,:)=F(spring(k).to,:)-f;
    end
    F(:,3)=F(:,3)-g*diag(M);

    % Update velocity
    v_new=v_old+M\F*step_size;
    % Update position
    x_new=x_old+v_new*step_size;

%     if mod(n,10)==0
% 
%         % Energi i ost-systemet
%         [a,b,c,d]=energy_ost(M,g,L,x_old,v_old,v_new,KS,NS,NP,spring);
%         E_tot(1,j)=a;
%         E_p(1,j)=b;
%         E_s(1,j)=c;
%         E_k(1,j)=d;
%         % Rotation point
%         rot=(x_old(1,1)+x_old(2,1))/2;
%         [length_spring,angular_frequency]=angular_momentum...
%             (M,NP,x_old,v_old,spring,NS,v_new,m_tot);
%         length(j)=length_spring;
%         omega(j)=angular_frequency;
%         j=j+1;
%     end

    % If particle hitting ground object
    for particle_number=1:NP
        for ground_number=1:NG
            if norm(x_new(particle_number,:)-G(ground_number,:))<Rg

                norm_length=norm(G(ground_number,:)-x_new(particle_number,:));
                my_norm=(G(ground_number,:)-x_new(particle_number,:))/norm_length;
                v_new(particle_number,:)=v_old(particle_number,:)...
                    -2*dot(v_old(particle_number,:),my_norm)*my_norm;

                x_new(particle_number,:)=x_new(particle_number,:)-...
                    my_norm*2*(Rg-norm_length);
            end
        end
    end

%    % Velocity for the center of mass
%     for k=1:NP
%         VCM(n,:)=VCM(n,:)+M(k,k)*v_new(k,:)/m_tot;
%     end

    x_old=x_new;
    v_old=v_new;

    % Uppdatera grafiken:
    if mod(n,1)==0
        
        for k=1:NP
           set(plot_3d_particles(1,k),...
               'XData',x_new(k,1),...
               'YData',x_new(k,2),...
               'ZData',x_new(k,3));
        end

        % Utritning av linjerna
        for k=1:NS
            set(plot_3d_lines(1,k),...
                'XData',[x_new(spring(k).from,1),x_new(spring(k).to,1)],...
                'YData',[x_new(spring(k).from,2),x_new(spring(k).to,2)],...
                'ZData',[x_new(spring(k).from,3),x_new(spring(k).to,3)]);
        end
        
        % Drawing of ground
        for k=1:NG
           set(ground(1,k),...
               'XData',x+G(k,1),...
               'YData',y+G(k,2),...
               'ZData',z+G(k,3));
        end
    end
    pause(0.0001);
end
% %friction my
% deriv_VCM=(VCM(end,1)-VCM(1,1))/time_step;
% my=deriv_VCM/g;
% 
% hold off
% figure(2)
% plot(E_tot)
% hold on
% plot(E_p)
% plot(E_s)
% plot(E_k)
% legend('E_{tot}','E_p','E_s','E_k')
% hold off
% 
% figure(3)
% plot(length)
% hold on
% plot(omega)
% legend('length','omega')
% hold off
% 
% figure(4)
% plot(VCM(:,1))
% legend('VCM')
% 
% error=max(E_tot)-min(E_tot);
% if error>0.01
%     disp(error)
% end