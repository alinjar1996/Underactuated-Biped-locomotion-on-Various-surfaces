function [value,isterminal,direction] = groundimpact_4degincline(t,q)

global P1_ground m  Q1_ground 
P1 = P1_ground;
Q1= Q1_ground;
% when value is equal to zero, an event is triggered.
% set isterminal to 1 to stop the solver at the first event, or 0 to
% get all the events.
%  direction=0 if all zeros are to be computed (the default), +1 if
%  only zeros where the event function is increasing, and -1 if only
%  zeros where the event function is decreasing.
tol = 0;
%x-cordinate of foot is = -P1+l1*sin(theta1)+l2*sin(theta2)+l3*sin(theta3)
%y-cordinate of foot is = -Q1-l1*cos(theta1)-l2*cos(theta2)-l3*cos(theta3)
% alpha=30*pi/180;
parameters
      r=8;

    %      y = (-l(1)*cos(q(1))-l(2)*cos(q(2))-l(3)*cos(q(3))); %plan terrain y=0
%   
   %      y= (-l(1)*cos(q(1))-l(2)*cos(q(2))-l(3)*cos(q(3))+r-Q1).^2+(l(1)*sin(q(1))+l(2)*sin(q(2))+l(3)*sin(q(3))-P1).^2-r^2;%circular surface
%    y=(-l(1)*cos(q(1))-l(2)*cos(q(2))-l(3)*cos(q(3))-Q1)-.1*(cos(1.5*(l(1)*sin(q(1))+l(2)*sin(q(2))+l(3)*sin(q(3))-P1))-1);%cosine_surface y=.1*(cos(1.5*x)-1);
       y = -(l(1)*cos(q(1))+l(2)*cos(q(2))+l(3)*cos(q(3))+Q1)-(l(1)*sin(q(1))+l(2)*sin(q(2))+l(3)*sin(q(3))-P1)*tand(4); %inclined plane y-mx=0;
% 
% value = 1;
% y = abs(-l(1)*cos(q(1))-l(2)*cos(q(2))-l(3)*cos(q(3)));
% 
% if (y<tol)
%     value = 0;  % when value = 0, an event is triggered
% end

value = (y(end)-tol);
isterminal = 1; % terminate after the first event
direction = 0;  % get all the zeros