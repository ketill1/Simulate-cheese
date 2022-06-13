close all
time_step=15;
step_size=0.001;
h=1e-7;
NS=1; NP=2; L=1; KS=10; KD=0; g=0; % number of stuff


X(1,1)=0;       % x-position
X(2,1)=1.8;     % x-position
X(1,2)=0;       % y-position
X(2,2)=0;       % y-position

V(1,1)=0;       % x-velocity
V(2,1)=0;       % x-velocity
V(1,2)=0;       % y-velocity
V(2,2)=0;       % y-velocity

spring_number=0;
for m=1:NS % loop over springs
    particle_number=m;
    spring_number=spring_number+1;
    spring(spring_number).from=particle_number; % number of the ''from'' particle
    spring(spring_number).to=particle_number+1; % number of the ''to'' particle
    spring(spring_number).length=L;             % spring rest length
    spring(spring_number).KS=KS;                % spring rest length 
    spring(spring_number).KD=KD;                % damping coefficient
end

%     to get
%     a=spring(2).from;
%     b=spring(2).to;

% Mass diagonal matrix
M=zeros(NP);
for c=1:3
    for r=1:NP
        if c==r
            M(c,r)=m;
        end
    end
end

% Parametervaerden
Rb=0.2;  % Radie

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Utritning av partiklar
particles=gobjects(NP,1);
for k=1:NP
    particles(k,1)=rectangle('Position',...
        [X(k,1)-Rb,X(k,2)-Rb,2*Rb,2*Rb],'Curvature',[1,1],'EdgeColor','b','FaceColor','w');
end

% Utritning av linjerna
springs=gobjects(NS);
springs(1)=line([X(1,1),X(2,1)],[X(1,2),X(2,2)]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Instaellningar for grafik-fonstret
daspect([1,1,1]);   % Skalar axlarna lika
axis([X(1,1)-5,X(1,1)+5,X(1,2)-5,X(1,2)+5]);    % Axlarnas intervall
hold on             % Laas fast dessa instaellningar

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Huvudslingan
N=time_step/step_size;
% Initial conditions
x_old=X;

for k=1:NS
    % distans mellan partiklar
    r=x_old(k,:)-x_old(k+1,:);
    % hastighetskillnad mellan partiklar
    r_prick=V(k,:)-V(k+1,:);
end
% Initial force calculation
f=-(KS*(norm(r)-L)+KD*(dot(r_prick,r))/norm(r))*r/norm(r);
f_old=[f;-f];

% half backwards Euler step to get V_{-1/2}
v_old=V-f_old*step_size/2;

E_tot=zeros(1,N);
E_p=zeros(1,N);
E_s=zeros(1,N);
E_k=zeros(1,N);

for n=1:N % Main loop
    
    % Updatera positioner
    % Force calculation (may involve x_old and v_old)
    for k=1:NS
        % distans mellan partiklar
        r=x_old(k,:)-x_old(k+1,:);
        % hastighetskillnad mellan partiklar
        r_prick=v_old(k,:)-v_old(k+1,:);
    end
    f=-(KS*(norm(r)-L)+KD*(dot(r_prick,r))/norm(r))*r/norm(r);
    f_old=[f;-f];
    v_new=v_old+M\f_old*step_size;                          % Update velocity
    x_new=x_old+v_new*step_size;                       % Update position
    
    
    
    
    if mod(n,2)==0
        % Uppdatera grafiken:
        % Utritning av partiklar
        for k=1:NP
            set(particles(k,1),'Position',[x_new(k,1)-Rb,x_new(k,2)-Rb,2*Rb,2*Rb]);
        end
        % Utritning av linjerna
        set(springs(1),'XData',[x_new(1,1),x_new(2,1)],'YData',[x_new(1,2),x_new(2,2)]);
        pause(0.0001);    % En paus for dra och chilla lite
    end
    
    
    % Energi i ost-systemet
    [a,b,c,d]=energy_ost(m,g,L,x_new,v_old,v_new,KS,NS,NP);
    E_tot(1,n)=a;
    E_p(1,n)=b;
    E_s(1,n)=c;
    E_k(1,n)=d;
    
end
hold off
plot(E_tot)
hold on
%plot(E_p)
plot(E_s)
plot(E_k)
legend('E_tot','E_s','E_k')