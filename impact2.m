function qf=impact2(q)

% to find angular momentum before impact, use velocities wrt stance foot

parameters

% th = [q(1); q(2); q(3)];
% thd = [q(4); q(5);q(6)];
% % 
% v1 = [l(1)*cos(th(1)) l(2)*cos(th(2));l(1)*sin(th(1)) l(2)*sin(th(2))]*[thd(1);thd(2)];
% v2 = [(a(2)+l(3))*cos(th(1));(a(2)+l(3))*sin(th(1))]*thd(1);
% v3 = [a(3)*cos(th(1));a(3)*sin(th(1))]*thd(1);
% % v=[v1 v2 v3];

% to find momentum after impact, switch the limbs
% q = [pi+q(2);q(1)-pi;q(1)-pi;q(5);q(4);q(4)];
q = [pi+q(2);q(1)-pi;q(1)-pi;q(5);q(4);q(4)];

th = [q(1); q(2); q(3)];
thd = [q(4); q(5);q(6)];
%%
% curved feet
% M11 = I1+m1*a(1)^2+m2*l(1)^2+m3*l(1)^2+2*r*(1+cos(th(1)))*(r*(m1+m2+m3)-(m1*a(1)+m2*l(1)+m3*l(1)));
% M12 = (m2*a(2)+m3*l(2))*((l(1)-r)*cos(th(2)-th(1))-r*cos(th(2)));
% M13 = m2*a(3)*((l(1)-r)*cos(th(3)-th(1))-r*cos(th(3)));
% M22 = I2+m2*a(2)^2+m3*l(2)^2;
% M23 = m3*a(3)*l(2)*cos(th(3)-th(2));
% M33 = I3+m3*a(3)^2;
%%
 %normalfeet
M11 = I1+m1*a(1)^2+m2*l(1)^2+m3*l(1)^2;
M12 = (m2*a(2)+m3*l(2))*l(1)*cos(th(2)-th(1));
M13 = m3*a(3)*l(1)*cos(th(3)-th(1));
M22 = I2+m2*a(2)^2+m3*l(2)^2;
M23 = m3*a(3)*l(2)*cos(th(3)-th(2));
M33 = I3+m3*a(3)^2;

M = [M11 M12 M13;
     M12 M22 M23;
     M13 M23 M33];
  
% % Momentum before impact from Ono's 2001 paper
% f1 = I1*thd(1)+(a(1)*m1*v1(1)+l(1)*(m2*v2(1)+m3*v3(1)))*cos(th(1))...
%     +(a(1)*m1*v1(2)+l(1)*(m2*v2(2)+m3*v3(2)))*sin(th(1));
% f2 = I2*thd(2)+(a(2)*m2*v2(1)+l(2)*m3*v3(1))*cos(th(2))...
%     +(a(2)*m2*v2(2)+l(2)*m3*v3(2))*sin(th(2));
% f3 = I3*thd(3)+a(3)*m3*v3(1)*cos(th(3))+a(3)*m3*v3(2)*sin(th(3));
% 
% qfd = M\[f1;f2;f3];

% Momentum calculation using Sangwan's 2004 paper
g1 = (m2*l(1)+m3*l(1)+m1*a(1))*[l(1) l(2)*cos(th(2)-th(1)) l(3)*cos(th(3)-th(1))]*thd;
g2 = (m2*a(2)+m3*l(2))*[l(1)*cos(th(2)-th(1)) l(2) l(3)*cos(th(3)-th(2))]*thd;
g3 = m3*a(3)*[l(1)*cos(th(3)-th(1)) l(2)*cos(th(3)-th(2)) l(3)]*thd;
 
% g1=l(1)*(m1*a(1)*thd(1)+m2*l(1)*thd(1)+m3*l(1)*thd(1)+m2*a2*thd(2)*cos(th(2)-th(1))+m3*a3*thd(3)*cos(th(3)-th(1))+m3*l2*thd(2)*cos(th(2)-th(1)));
% g2=l(2)*(m2*a(2)*thd(2)+m3*l(2)*thd(2)+m1*a(1)*thd(1)*cos(th(2)-th(1))+m3*a3*thd(3)*cos(th(2)-th(3))+m2*l1*thd(1)*cos(th(1)-th(2))+m3*l1*thd(1)*cos(th(2)-th(1)));
% g3=l(3)*(m3*a(3)*thd(3)+m1*a(1)*thd(1)*cos(th(3)-th(1))+m2*a(2)*thd(2)*cos(th(2)-th(3))+m2*l1*thd(1)*cos(th(3)-th(1))+m3*l1*thd(1)*cos(th(1)-th(3))+m3*l2*thd(2)*cos(th(2)-th(3)));
 g = [g1;g2;g3]; 
qfd = thd-M\g;
        
qf = [th;qfd];

%         M=[I1+m1*a(1)^2+m2*l(1)^2+m3*l(1)^2 -(m2*a(2)+m3*l(2))*l(1) -m3*a(3)*l(1);
%             -(m2*a(2)+m3*l(2))*l(1) I2+m2*a(2)^2+m3*l(2)^2 m3*a(3)*l(2);
%             -m3*a(3)*l(1) m3*a(3)*l(2) I3+m3*a(3)^2];
%         IM=inv(M);
% 
%         G=[(m2*l(1)+m3*l(1)+m1*a(1))*l(1) -(m2*l(1)+m3*l(1)+m1*a(1))*l(2)*cos(2*q(1)) -(m2*l(1)+m3*l(1)+m1*a(1))*l(3)*cos(2*q(1));
%             -(m2*a(2)+m3*l(2))*l(1)*cos(2*q(1)) (m2*a(2)+m3*l(2))*l(2) (m2*a(2)+m3*l(2))*l(3);
%             -m3*a(3)*l(1)*cos(2*q(1)) m3*a(3)*l(2) m3*a(3)*l(3)];
%         
%         X=(eye(3)-IM*G)*[q(5);q(4);q(4)];
%         
%         qf=[pi+q(2);q(1)-pi;q(1)-pi;X];
 

