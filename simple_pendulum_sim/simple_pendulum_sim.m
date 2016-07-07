function pendulum_sim()
    clf;
    clear;
    
    time_step = 0.01;
    time_span = [0:time_step:15];
    
    initial_condition = [pi; 0];     % initial state of pendulum
    
    l = 1;      % length of pendulum arm
    m = 1;      % mass at end of pendulum arm
    
    % feedback linearized pendulum system
    A = [ 0 1;
          0 0 ];
    B = [ 0;
          1/m*l*l];
    
    Q = diag([1 1]);    % penalizes states
    R = 0.1;            % penalizes control actions
    
    [K,S] = lqr(A,B,Q,R);
    
    % simulate pendulum system
    [t,y] = ode45(@(t,x) simple_pendulum_sys(t,x,K), time_span, initial_condition);
    
    % animate results
    animate_pendulum(y(:,1));
    
end

function animate_pendulum(ang_pos)
    axis([-2,2,-2,2]);
    grid on;
    
    for n=1:length(ang_pos)
        XY_end_pos = [sin(ang_pos(n)),cos(ang_pos(n))];
        
        cla(gca);
        hold on;
        plot([0,XY_end_pos(1)],[0,XY_end_pos(2)],'LineWidth',3);
        plot(XY_end_pos(1),XY_end_pos(2),'b.','MarkerSize',50);
        hold off;
        
        drawnow;
    end
end
