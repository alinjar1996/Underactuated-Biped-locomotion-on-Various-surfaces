
%%
%steplengthcalculation
Steplengthx= 0;
Steplengthy= 0;
P2=diff(P1);
Q2=diff(Q1);
 P3=[];W=[];
 Q3=[];V=[];
 %x-cordinate of foot is = -P1+l1*sin(theta1)+l2*sin(theta2)+l3*sin(theta3)
%y-cordinate of foot is = -Q1-l1*cos(theta1)-l2*cos(theta2)-l3*cos(theta3)
for w=1:length(P2)
if (P2(w))~=0
    W=[W w];
P3=[P3 P2(w)];
end
end
for v=1:length(Q2)
if (Q2(v))~=0
    V=[V v];
Q3=[Q3 Q2(v)];
end
end


Steplengthx(1)= -(l(1)*sin(q(W(1),1))+l(2)*sin(q(W(1),2))+l(3)*sin(q(W(1),3)))+(l(1)*sin(q(1,1))+l(2)*sin(q(1,2))+l(3)*sin(q(1,3)));

for i=2:length(W)
    Steplengthx(i)=l(1)*sin(q(W(i)+1,1))+l(2)*sin(q(W(i)+1,2))+l(3)*sin(q(W(i)+1,3))-l(1)*sin(q(W(i-1),1))-l(2)*sin(q(W(i-1),2))-l(3)*sin(q(W(i-1),3));   
end

Steplengthy(1)= -(l(1)*cos(q(V(1),1))+l(2)*cos(q(V(1),2))+l(3)*cos(q(V(1),3)))+(l(1)*cos(q(1,1))+l(2)*cos(q(1,2))+l(3)*cos(q(1,3)));

Steplength(1) =  sqrt(Steplengthy(1)^2+Steplengthx(1)^2);

for i=2:length(V)
    Steplengthy(i)=l(1)*cos(q(V(i)+1,1))+l(2)*cos(q(V(i)+1,2))+l(3)*cos(q(V(i)+1,3))-l(1)*cos(q(V(i-1),1))-l(2)*cos(q(V(i-1),2))-l(3)*cos(q(W(i-1),3));   
    Steplength(i) = sqrt(Steplengthy(i)^2+Steplengthx(i)^2);
end

Steplengthx(length(W)+1)= -(l(1)*sin(q(end,1))+l(2)*sin(q(end,2))+l(3)*sin(q(end,3)))-P3(end);
Steplengthy(length(V)+1)= -(l(1)*cos(q(end,1))+l(2)*cos(q(end,2))+l(3)*cos(q(end,3)))-Q3(end);
Steplength(length(W)+1) = sqrt(Steplengthy(length(W)+1)^2+Steplengthx(length(W)+1)^2);


% Steplength(14)=Steplength(13)-0.001
% plot(-P3)
plot((1:length(Steplength)),Steplength(1:length(Steplength)), 'linewidth', 3)
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
    if abs(q(i,3)-q(i,2))>0.01
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
   Vxhip(i) = -l(1)*sin(q(i,1))*q(i,4);
   Vxhipabs(i)= abs(Vxhip(i));
   Vxhipsqr(i)= Vxhip(i)^2;  
end
%avghipvel = mean(Vxhipabs)
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
global savex5
r = 8;
clear swlegclearance swlegclearance1 swlegclearance2 
for i =1:length(savex5)-1
   % if Q1(i)==0
  % ydash(i)=0;
  %  else
   ydash(i) = -r+sqrt(r^2-savex5(i)^2);
   swlegclearance1(i)= savey5(i)-ydash(i); 
   swlegclearance2(i)= savey5(i)-Q1(i);
   %swlegclearance(i)=max(swlegclearance1(i),swlegclearance2(i));

   %swlegclearance(i)=max(swlegclearance1(i),swlegclearance2(i));

   if Q1(i) ==0

       swlegclearance(i) = swlegclearance2(i);

   else    

       swlegclearance(i) = swlegclearance1(i);

   end
    
end    

%plot(t,(savey5-Q1).*1000,  'linewidth', 3)
%plot(t,(savey5-ydash).*1000,  'linewidth', 3)
plot(t(1:length(swlegclearance)),swlegclearance.*1000,  'linewidth', 3)
xlabel('Time (s)')
ylabel('Clearance (mm)')
set(gca,'fontsize',36, 'fontname', "Euclid")
