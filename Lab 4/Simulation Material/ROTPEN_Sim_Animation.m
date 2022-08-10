function ROTPEN_Sim_Animation(the, alp, the_lin, alp_lin, control_threshold, tout)
%
% Basic animation function for Rotary Inverted Pendulum Nonlinear Simulation
% D. Hartman, 2016
%
%
% Setup rotation functions for rotary inverted pendulum
R1 = @(the)[cos(the) -sin(the) 0; sin(the) cos(the) 0; 0 0 1]; % This is actualy Rz rotation
R2 = @(alp)[1 0 0;0 cos(alp) -sin(alp); 0 sin(alp) cos(alp)]; % This is actually Rx rotation

% Length of first segment
L1 = [0; 0; 0]; % Displacement of first coordinate system
L2 = [1; 0; 0]; % Displacement of second coordinate system

% Build homogeneous transformation matrices to represent pose of arms
T1 = @(the)[   R1(the), L1;
            zeros(1,3),  1]; % Coordinate system rotated to match theta
T2 = @(alp)[   R2(alp), L2;
            zeros(1,3),  1]; % Displacement to end of base arm and rotation to match alpha

% Position of base arm endpoint at t=0
base = [0,0,0];

% Position of end of base arm function
end1 = @(the)T1(the)*[1;0;0;1];

% position of end of upright arm function
end2 = @(the,alp)T1(the)*T2(alp)*[0;0;1;1];

% Create figure
figure;

% Create stop botton
stop = uicontrol('style','toggle','string','stop',...
    'background',[1 0.1 0.1],'units','normalized',...
    'position',[0.9 0.9 0.1 0.05]);
%      % Size the figure for (hopefully) better viewing
%      set(ax,'units','normalized','outerposition',[0.1 0.1 0.8 0.8]);

% Calculate initial arm end positions
e1 = end1(the(1));
e2 = end2(the(1),alp(1));
e1_lin = end1(the_lin(1));
e2_lin = end2(the_lin(1),alp_lin(1));

% Plot lines for first end positions and hold plot settings
h_P1 = line([base(1) e1(1)],[base(2) e1(2)],[base(3) e1(3)],'Color','b',...
    'Marker','s','LineWidth',3);
hold all
h_P2 = line([e1(1)   e2(1)],[e1(2)   e2(2)],[e1(3)   e2(3)],'Color','b',...
    'Marker','s','LineWidth',3);
% Linear animation
h_P3 = line([base(1) e1_lin(1)],[base(2) e1_lin(2)],[base(3) e1_lin(3)],'Color',[0.5 0.5 1],...
    'Marker','^','LineWidth',3,'LineStyle','--');
hold all
h_P4 = line([e1(1)   e2_lin(1)],[e1(2)   e2_lin(2)],[e1(3)   e2_lin(3)],'Color',[0.5 0.5 1],...
    'Marker','^','LineWidth',3,'LineStyle','--');
legend([h_P1 h_P3],'Nonlinear Sim','Linear Sim')
view(42,29)
xlim([-1.5 1.5])
ylim([-1.5 1.5])
zlim([-1.5 1.5])
grid on
axis square
xlabel('X')
ylabel('Y')
zlabel('Z')
animQ = 'Yes';
ax = gca;

% Start loop to manage animation
while strcmp(animQ,'Yes');
    tic % used to restrict simulation to run no faster than real time
    for i = 1:1:length(tout)
        while toc < tout(i)
            % do nothing for near real time plotting (assuming fast enough
            % machine and sparse enough simulation points)
        end
        e1 = end1(the(i));
        e2 = end2(the(i),alp(i));
        e1_lin = end1(the_lin(i));
        e2_lin = end2(the_lin(i),alp_lin(i));
        h_P1.XData = [base(1), e1(1)];
        h_P1.YData = [base(2), e1(2)];
        h_P1.ZData = [base(3), e1(3)];
        h_P2.XData = [e1(1), e2(1)];
        h_P2.YData = [e1(2), e2(2)];
        h_P2.ZData = [e1(3), e2(3)];
        
        h_P3.XData = [base(1), e1_lin(1)];
        h_P3.YData = [base(2), e1_lin(2)];
        h_P3.ZData = [base(3), e1_lin(3)];
        h_P4.XData = [e1_lin(1), e2_lin(1)];
        h_P4.YData = [e1_lin(2), e2_lin(2)];
        h_P4.ZData = [e1_lin(3), e2_lin(3)];
        
        if abs(alp(i)) < control_threshold
            title(ax,{['Time = ' num2str(tout(i)) ' s '], 'Controller ON'},...
                'Color','k')
        else
            title(ax,{['Time = ' num2str(tout(i)) ' s '], 'Controller OFF (Nonlinear Simulation)'},...
                'Color','r')
        end
        
        if get(stop,'value')==0
            drawnow
        else
            break
        end
    end
    % Ask user if they want to continue animation
    animQ = questdlg('Do you want to run the animation again?','Animation Control','Yes','No','No');
    set(stop,'value',0);
end
drawnow

end
