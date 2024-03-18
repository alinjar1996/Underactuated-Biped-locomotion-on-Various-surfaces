function qf=impact2_rough(q)
 
q = [q(1);q(1);q(3);q(4);q(4);q(6)];


th = [q(1); q(2); q(3)];
thd = [q(4); q(5);q(6)];

m3 = 4;m1 = 2; m2 = 2;
I3 = 0.21; I1 = 0.027;I2=0.027;
l = [0.4 0.4 0.8];
a =[0.2 0.2 0.4];


M11 = I1+m1*a(1)^2+m2*l(1)^2+m3*l(1)^2;
M12  = (m2*a(2)+m3*l(2))*l(1)*cos(th(2)-th(1));
M13 = m3*a(3)*l(1)*cos(th(3)-th(1));
M22 = I2+m2*a(2)^2+m3*l(2)^2;
M23 = m3*a(3)*l(2)*cos(th(3)-th(2));
M33 = I3+m3*a(3)^2;

M = [M11 M12 M13;
     M12 M22 M23;
     M13 M23 M33];
 
 
% g1 = (m2*l(1)+m3*l(1)+m1*a(1))*[l(1) l(2)*cos(th(2)-th(1)) l(3)*cos(th(3)-th(1))]*thd;
% g2 = (m2*a(2)+m3*l(2))*[l(1)*cos(th(2)-th(1)) l(2) l(3)*cos(th(3)-th(2))]*thd;
% g3 = (m2*l(1)+m3*l(1)+m1*a(1))*[l(1)*cos(th(3)-th(1)) l(2)*cos(th(3)-th(2)) l(3)]*thd;
% 
% g = [g1;g2;g3];
% 
% qfd = thd-M\g;

J = [l(1)*cos(th(1)) l(2)*cos(th(2)) l(3)*cos(th(3));
     l(1)*sin(th(1)) l(2)*sin(th(2)) l(3)*sin(th(3))];
 
 A = [M J';
     J zeros(2,2)];
 
 b = [M*thd;
     zeros(2,1)];
 
 qfd = A\b;
 
 qfd = qfd(1:3);
 
 
 qf = [pi+th(3);th(2)-pi;th(1)-pi;qfd(3);qfd(2);qfd(1)];
