
L=1;
v0=0.01;
time_step=1500;
step_size=0.1;
m=1;
h=1e-7;

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
% Example to get X,V value, (The y-position of particle 3 is x(3,2))

% Mass diagonal matrix 
M=zeros(3);
for c=1:3
    for r=1:3
        if c==r
            M(c,r)=m;
        end
    end
end
N=time_step/step_size;
v_new=V;

for n=1:N                              % Main loop
    x_old=X;                                % Initial conditions
    v_old=euler_half_step_backaward(v_new,step_size,NP); % Euler half step backwards
    F=0.5*(0.5-rand(NP,2))-0.1*v_old;       % Force calculation (may involve x_old and v_old)
    v_new=v_old+M\F*step_size;                   % Update velocity
    x_new=x_old+v_new*step_size;              % Update position
end


% NS=3; KS=10; KD=0.1;    % number of springs, rest length etc
% spring_number=0;    

for m=1:NS % loop over springs
    particle_number=m;
    spring(spring_number).from=particle_number; % number of the ''from'' particle
    spring(spring_number).to=particle_number+1; % number of the ''to'' particle
    spring(spring_number).length=L;             % spring rest length
    spring(spring_number).KS=KS;                % spring rest length 
    spring(spring_number).KD=KD;                % damping coefficient
end

    to get
    a=spring(2).from;
    b=spring(2).to;
    
    
    
    
    
    
    
    
    
    


