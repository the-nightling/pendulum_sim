function [dx] = simple_pendulum_sys(t,x,K)

    g = 9.8;    % acceleration due to gravity
    b = 0.4;    % damping
    l = 1;      % length of pendulum arm
    m = 1;      % mass at end of pendulum arm
    
    v = -K*x;
    
    u = v + b*x(2) + m*g*l*sin(x(1));
%    u = 0;
    
    dx = [  x(2);
            (1/(m*l*l)) * ( u - b*x(2) - m*g*l*sin(x(1)) );  ];
end
