function [value,isterminal,direction] = kneeimpact(t,q,P1)

% when value is equal to zero, an event is triggered.
% set isterminal to 1 to stop the solver at the first event, or 0 to
% get all the events.
%  direction=0 if all zeros are to be computed (the default), +1 if
%  only zeros where the event function is increasing, and -1 if only
%  zeros where the event function is decreasing.
tol =0/57.3;%5e-3;

% value = 1;
% if(q(2)<0 && abs(q(2)-q(3))<tol)%erp*(q(2)-q(3))<0
%     value = 0;  % when value = 0, an event is triggered
% end

value = q(2)-q(3)-tol;
isterminal = 1; % terminate after the first event
direction = 1;  % get zeros where the event function is increasing

