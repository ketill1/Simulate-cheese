
L=1;
v0=0.01;
time_step=1500;
step_size=0.1;
m=1;
h=1e-7;

NL=3; %number of lines
NP=3; %number of particles
for a=1:NP
particle_number=a;
    X(1,1)=-L/2;    % x-position
    X(2,1)=L/2;     % x-position
    X(3,1)=0;       % x-position
    
    X(1,2)=0;       % y-position 
    X(2,2)=0;       % y-position 
    X(3,2)=L/2;     % y-position 
    
    V(1,1)=v0;      % x-velocity
    V(2,1)=0;       % x-velocity
    V(3,1)=-v0/2;   % x-velocity
      
    V(1,2)=0;       % y-velocity
    V(2,2)=-v0;     % y-velocity
    V(3,2)=-v0/2;   % y-velocity
end

% Mass diagonal matrix 
M=zeros(3);
for c=1:3
    for r=1:3
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
 lines=gobjects(NL);
 lines(1)=line([X(1,1),X(2,1)],[X(1,2),X(2,2)]);
 lines(2)=line([X(2,1),X(3,1)],[X(2,2),X(3,2)]);
 lines(3)=line([X(3,1),X(1,1)],[X(3,2),X(1,2)]);
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Instaellningar for grafik-fonstret
daspect([1,1,1]);   % Skalar axlarna lika
axis([0,8,0,6]);    % Axlarnas intervall
hold on             % Laas fast dessa instaellningar

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Huvudslingan
N=time_step/step_size;
v_new=V; % Initial conditions
x_new=X; % Initial conditions
for n=1:N % Main loop
    
    % Updatera positioner
    x_old=x_new;
    v_old=euler_half_step_backaward(v_new,step_size,NP); % Euler half step backwards
    F=0.5*(0.5-rand(NP,2))-0.1*v_old;                    % Force calculation (may involve x_old and v_old)
    v_new=v_old+M\F*step_size;                           % Update velocity
    x_new=x_old+v_new*step_size;                         % Update position
    
    % Uppdatera grafiken:
    % Utritning av partiklar
    for k=1:NP
        set(particles(k,1),'Position',[x_new(k,1)-Rb,x_new(k,2)-Rb,2*Rb,2*Rb]);
    end
    
    % Utritning av linjerna
    set(lines(1),'XData',[x_new(1,1),x_new(2,1)],'YData',[x_new(1,2),x_new(2,2)]);
    set(lines(2),'XData',[x_new(2,1),x_new(3,1)],'YData',[x_new(2,2),x_new(3,2)]);
    set(lines(3),'XData',[x_new(3,1),x_new(1,1)],'YData',[x_new(3,2),x_new(1,2)]);
    
    pause(0.01);    % En paus for dra ner paa tempot
end
