
%%
%steplengthcalculation

P2=diff(P1);
 P3=[];W=[];
 %x-cordinate of foot is = -P1+l1*sin(theta1)+l2*sin(theta2)+l3*sin(theta3)
%y-cordinate of foot is = -Q1-l1*cos(theta1)-l2*cos(theta2)-l3*cos(theta3)
for w=1:length(P2)
if (P2(w))~=0
    W=[W w];
    P3=[P3 P2(w)];
end
end
Steplength= -(l(1)*sin(q(W(1),1))+l(2)*sin(q(W(1),2))+l(3)*sin(q(W(1),3)))+(l(1)*sin(q(1,1))+l(2)*sin(q(1,2))+l(3)*sin(q(1,3)));
for i=2:length(W)
    Steplength(i)=l(1)*sin(q(W(i)+1,1))+l(2)*sin(q(W(i)+1,2))+l(3)*sin(q(W(i)+1,3))-l(1)*sin(q(W(i-1),1))-l(2)*sin(q(W(i-1),2))-l(3)*sin(q(W(i-1),3));
    
end
Steplength(length(W)+1)= -(l(1)*sin(q(end,1))+l(2)*sin(q(end,2))+l(3)*sin(q(end,3)))-P3(end);

% Steplength(14)=Steplength(13)-0.001
% plot(-P3)
figure
plot(1:length(Steplength),Steplength(1:length(Steplength)), 'linewidth', 3)
 xlabel('Number of steps')
 ylabel('Steplength (m)')
 set(gca,'fontsize',36, 'fontname', "Euclid")
 %%
 % hip torque

 D=diff(t);
for i=1:length(t)
    if abs(q(i,3)-q(i,2))>0.001
     %Instanteneouspower(i)=abs((k*q(i,3)+kd*q(i,6))*q(i,5))*D(i);
     Hiptorque(i)=(k*q(i,3)+kd*q(i,6));
    else
     Hiptorque(i)=0;
    end
end
plot(t,Hiptorque);
%%
%powerconsumed
D=diff(t);
for i=1:length(t)-1
    if abs(q(i,3)-q(i,2))>0.001
     %Instanteneouspower(i)=abs((k*q(i,3)+kd*q(i,6))*q(i,5))*D(i);
     Instanteneouspower(i)=abs((k*q(i,3)+kd*q(i,6))*q(i,5))*D(i);
    else
     Instanteneouspower(i) = 0;
     
    end
end
Power=sum(Instanteneouspower)/t(end)
%for inclined plane walking total power per cycle=54.6060/15=3.6404 watt;
%efficiency=0.1847
%for flat plane walking total power per cycle=7.9521/15=0.5301 watt;
 %efficiency=0.4956
%for curved plane walking total power per cycle=7.9719/5=1.5944 watt;
%efficiency=0.3690
%averagepower=3.79W
%%
%hip velocity
for i=1:length(t)
   % Vxhip(i)=-l(1)*cos(q(i,1))*q(i,4)*cosd(6)-l(1)*sin(q(i,1))*q(i,4)*sind(6);
   %Vxhip(i) = -l(1)*sin(q(i,1))*q(i,4);
   Vxhip(i) = l(1)*cos(q(i,1))*q(i,4);
   Vxhipabs(i)= abs(Vxhip(i));
   Vxhipsqr(i)= Vxhip(i)^2;
end
rmshipvel = sqrt(sum(Vxhipsqr)/t(end))
plot(t,Vxhip, 'linewidth', 2)
xlabel("Time(s)")
ylabel("Hip velocity (m/s)")
set(gca,'fontsize',36, 'fontname', 'Euclid')

%0.6725 for inclined plane
% 0.2627 for flat plane
% 0.5884 for circular plane

%%
%swing_leg_clearance
plot(t,savey5.*1000,  'linewidth', 3)
xlabel('Time (s)')
ylabel('Swing leg clearance (mm)')
set(gca,'fontsize',36, 'fontname', "Euclid")


