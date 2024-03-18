function qf=impact1(q)

th = [q(1); q(2); q(3)];
thd = [q(4); q(5);q(6)];

parameters
%%
% curvedfeet
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
 
 syms tau
% 
 qfd = thd+M\[0;tau;-tau];
 tau1 = solve(qfd(2)-qfd(3)==0,tau);
 qfd = thd+M\[0;tau1;-tau1];
     
% IM = M\eye(3);
%  tau = (thd(2)-thd(3))/(IM(2,2)+IM(3,3)-2*IM(2,3));
% 
% qfd = thd+M\[0;-tau;tau];

qf = [th;qfd];
