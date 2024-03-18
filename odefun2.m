function qdot=odefun2(t,q)
th = [q(1); q(2)];
thd = [q(4); q(5)];

global k kd saveAB saveA saveB q0
% phase 2
parameters
m2 = m1; 
I2 = I1;
l(2)= l(1);
a(2) = a(1);

M = [I1+m1*a(1)^2+m2*l(1)^2 m2*a(2)*l(1)*cos(th(2)-th(1));
    m2*a(2)*l(1)*cos(th(2)-th(1))    I2+m2*a(2)^2];
C = [0 -m2*a(2)*l(1)*sin(th(2)-th(1))*thd(2);
    m2*a(2)*l(1)*sin(th(2)-th(1))*thd(1)  0];
K = [(m1*a(1)+m2*l(1))*g*sin(th(1));
     m2*a(2)*g*sin(th(2))];
%  B=-l(1)*sin(q0(1))-l(2)*sin(q0(2))-l(3)*sin(q0(3));
% A=l(1)*cos(q0(1))+l(2)*cos(q0(2))+l(3)*cos(q0(3));
% AB=-l(1)*sin(th(1))-l(2)*sin(th(2))-l(3)*sin(th(3))/(l(1)*cos(th(1))+l(2)*cos(th(2))+l(3)*cos(th(3)))
% AB=A/B;
% saveA= [saveA A];
% saveB= [saveB B];
%  saveAB= [saveAB AB];
 
  T2 = -0.0*[-k*th(2)-kd*thd(2);0];
thdd = M\(-C*thd-K+T2);

qdot = [thd;thd(2);thdd;thdd(2)];


