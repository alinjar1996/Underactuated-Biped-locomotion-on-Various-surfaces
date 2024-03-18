                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
function qdot=odefun1(t,q)
global k kd saveAB saveA saveB j An fn
th = [q(1); q(2); q(3)];                               
thd = [q(4); q(5);q(6)];

global P1_ground m  Q1_ground q0 uH phi
P1 = P1_ground;
Q1= Q1_ground;
parameters
% lambda=sqrt(m1*(a(1)+l(1))*g/I1)
% lambda*cosh(lambda*1.3/4)/sinh(lambda*1.3/4)
%     
 uH=An*sin(2*pi*fn*t+phi);
% uH=0;
M11 = I1+m1*a(1)^2+m2*l(1)^2+m3*l(1)^2;
M12 = (m2*a(2)+m3*l(2))*l(1)*cos(th(2)-th(1));
M13 = m3*a(3)*l(1)*cos(th(3)-th(1));
M22 = I2+m2*a(2)^2+m3*l(2)^2;
M23 = m3*a(3)*l(2)*cos(th(3)-th(2));
M33 = I3+m3*a(3)^2;

C12 = -(m2*a(2)+m3*l(2))*l(1)*sin(th(2)-th(1));
C13 = -m3*a(3)*l(1)*sin(th(3)-th(1));
C23 = -m3*a(3)*l(2)*sin(th(3)-th(2));

K1 = (m1*a(1)+m2*l(1)+m3*l(1))*g*sin(th(1));
K2 = (m2*a(2)+m3*l(2))*g*sin(th(2));
K3 = m3*a(3)*g*sin(th(3));

% phase 1
M = [M11 M12 M13;
     M12 M22 M23;
     M13 M23 M33];
C = [0 C12*thd(2) C13*thd(3);
     -C12*thd(1) G C23*thd(3)-G;
     -C13*thd(1) -C23*thd(2)-G G];
K = [K1;K2;K3];
%%
%for controlling over different terrains
B=-l(1)*sin(q0(1))-l(2)*sin(q0(2))-l(3)*sin(q0(3));
A=l(1)*cos(q0(1))+l(2)*cos(q0(2))+l(3)*cos(q0(3));
% AB=-l(1)*sin(th(1))-l(2)*sin(th(2))-l(3)*sin(th(3))/(l(1)*cos(th(1))+l(2)*cos(th(2))+l(3)*cos(th(3)))
AB=A/B;
saveA= [saveA A];
saveB= [saveB B];
 saveAB= [saveAB AB];
m12=m1+m2;l12=l(1)+l(2);
%%
%   T2 = -[-k*th(3)-kd*thd(3);k*th(3)+kd*thd(3);0];
% T2 = -[-k*th(3)-kd*thd(3);k*th(3)+kd*thd(3);0]+K*(1-cosd(4))-0*(k/125)*[AB;-AB;0];
%  T2 =
%  [k*th(3)+kd*thd(3);-k*th(3)-kd*thd(3);0]+(k/6)*[-sin(AB);sin(AB);0];%satisfactory result upto n=6 for 4degree inclined plane

%      T2=[k*th(3)+kd*thd(3);-k*th(3)-kd*thd(3);0]+(1*k/120)*[-(atan(AB));(atan(AB));0]%satisfactory result upto n=12 for 4degree inclined plane



 %   T2=[k*(th(3))+kd*thd(3)+uH;-k*(th(3))-kd*thd(3)-uH;0]+(0*k/120)*[-(atan(AB));(atan(AB));0];
global Th saveTh check



T2=[k*(th(3))+kd*thd(3)+uH;-k*(th(3))-kd*thd(3)-uH;0];

Th = T2(1);

saveTh = [saveTh Th];

%   T2 = -[-k*th(3)-kd*thd(3)-m12*g*l12*sin(AB);k*th(3)+kd*thd(3)+m12*g*l12*sin(AB);0];
% T2 = -[-k*th(3)-kd*thd(3)-0.5*tan(th(3));k*th(3)+kd*thd(3)+0.5*tan(th(3));0]; %for controlling geometry

thdd = M\(-C*thd-K+T2);

qdot = [thd;thdd];








