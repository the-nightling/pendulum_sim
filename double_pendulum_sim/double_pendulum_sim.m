function double_pendulum_sim()
    clf;
    clear;
    
    time_step = 0.01;
    time_span = [0:time_step:5];
    
    initial_condition = [pi/2; 0; 0; 0];     % initial state of pendulum
    
    tau = 0;
    
    % simulate pendulum system
    [t,y] = ode45(@(t,x) double_pendulum_sys(t,x,tau), time_span, initial_condition);
    
    % animate results
    animate_pendulum([y(:,1),y(:,3)]);
    
end

%%{
function animate_pendulum(ang_pos)
    axis([-3,3,-3,3]);
    grid on;
    
    for n=1:length(ang_pos)
        link1_end_pos = [sin(ang_pos(n,1)),-cos(ang_pos(n,1))];
        link2_end_pos = [sin(ang_pos(n,1)+ang_pos(n,2))+link1_end_pos(1),-cos(ang_pos(n,1)+ang_pos(n,2))+link1_end_pos(2)];
        
        cla(gca);
        hold on;
        plot([0,link1_end_pos(1)],[0,link1_end_pos(2)],'LineWidth',3);
        plot([link1_end_pos(1),link2_end_pos(1)],[link1_end_pos(2),link2_end_pos(2)],'LineWidth',3);

        hold off;
        
        drawnow;
    end
end
%}
