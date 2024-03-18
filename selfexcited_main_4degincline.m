clear all;clc;close all;



global k kd j phi;


global saveX1 saveX2 saveX3 saveY1 saveY2 saveY3 savex1 savex2 savex3 savex4 savex5 savey1 savey2 savey3 savey4 savey5 savezmp saveth1 saveth2 saveth3 savecg saveAB q0 saveA saveB An fn Tn savephi saveTD
saveX1 = [];saveX2= [];saveX3= [];saveY1= [];saveY2= [];saveY3= [];savecg=[];savephi=[];saveTD=[];
savex1 = [];savex2= [];savex3= [];savex4= [];savex5= [];savey1= [];savey2= [];savey3= [];savey4= [];savey5= [];savezmp=[];saveth1=[];saveth2=[];saveth3=[];saveAB=[];saveA=[];saveB=[];
  k = 5.9;
 An=0;fn=0.77;
 Tn=(1/fn);
 phi=0;
 %kd=0; %flat_surface
 %  kd=1;%2 degree inclined plane
     %  kd=0.67;%4 degree inclined plane

       kd = 0.5;%4 degree inclined plane
    %  kd =1.25; %for circle roc = 8
%  kd=1.2;
  
% k=6; %curved feet
q01 = -0.14+pi;
    q0 = [q01;pi-q01;pi-q01;1.13;0;0];%normalfeet
%  q0 = [2.71;0.348;0.348;7.53*0.348;0;0];%r=7,alpha=5degree
%  q0 = [q01;pi-q01;pi-q01;7.39*(pi-q01);0;0];%curvedfeet
%  q0 = [q01;pi-q01;pi-q01;10.00*(pi-q01);0;0];
% k = 8;
% q01 = -0.11+pi;
% q0 = [q01;pi-q01;pi-q01;6*(pi-q01);0;0];

% k = 9;
% q01 = -0.1+pi;
% q0 = [q01;pi-q01;pi-q0a1;6*(pi-q01);0;0];

% k = 9.2;
% q01 = -0.096+pi;
% q0 = [q01;pi-q01;pi-q01;6*(pi-q01);0;0];


n = 10;% no of cycles
t0 = 0;

t=[];q=[];qdot=[];Thip = [];
P1 = [];
Q1 = [];
x0 = 0;
y0 = 0;

parameters
 
% figure()
% hold on

for j= 1:n
    %PHASE I
tspan = linspace(t0,t0+1,100);%[t0 t0+1];
options1 = odeset('Events',@kneeimpact);%,'MaxStep',2.5000e-05);
[t1,q1] = ode45(@odefun1,tspan,q0,options1);
q1dot =[];
for jj =1:length(t1)
      
       if jj == 1
      
      D(jj) = 0;

      else

      D(jj)= t1(jj)-t1(jj-1);  
      end
      
      q1dot(jj,:)=odefun1(t1(jj),q1(jj,:));

      Thip1(jj,:) = k*q1(jj,3)+kd*q1(jj,6); % hip torque
end

% phase II
i = length(t1);
P1 = [P1 x0*ones(1,i)];
Q1 = [Q1 y0*ones(1,i)];
q0 = double(impact1(q1(i,:)));                                         
global P1_ground Q1_ground 
P1_ground = P1;
Q1_ground = Q1;
tspan = linspace(t1(i),t0+2,100);%[t1(i) t0+2];
options2 = odeset('Events',@groundimpact_4degincline);%,'MaxStep',2.5000e-05);
[t2,q2] = ode45(@odefun2,tspan,q0,options2);
q2dot =[];
 for kk =1:length(t2)
    
     q2dot(kk,:)=odefun2(t2(kk),q2(kk,:));
     
     Thip2(kk,:) = 0;
 
 end

 Thip = [Thip; Thip1; Thip2];
 t = [t;t1;t2];q=[q;q1;q2];qdot=[qdot;q1dot;q2dot];

i = length(t2);
TD=t2(i)-t1(1); %new addition
%saveTD=[saveTD TD]
phi=(0.5*Tn-TD)*2*pi*fn ;%new addition
%savephi=[savephi phi]
P1 = [P1 x0*ones(1,i)];
Q1 = [Q1 y0*ones(1,i)];
q0 = double(impact2(q2(i,:)));
t0 = t2(i);
x0 = x0-(l(1)*sin(q0(1))+l(2)*sin(q0(2))+l(3)*sin(q0(3)));
y0 = y0+(l(1)*cos(q0(1))+l(2)*cos(q0(2))+l(3)*cos(q0(3)));
% 
if j ==n || j==n-2
%     temp =[2*pi-q0(1) q0(2) -q0(3) q0(6) q0(5) q0(4)];
    temp =[pi+q0(3) q0(2) q0(1)-pi q0(6) q0(5) q0(4)];
    tt = [t1;t2];qq=[q1;q2;temp];
    figure()
   hold on
   graph1=plot(qq(:,3)*180/pi,qq(:,6)*180/pi);
    graph2 = plot(qq(:,1)*180/pi-180,qq(:,4)*180/pi);
        set(graph1,'LineWidth',2);
     set(graph2,'LineWidth',2);
legend('\theta_3','\theta_1') 
  xlabel('Angular position  $\theta_1-180 , \theta_3$ (deg)',  'interpreter','latex')
   ylabel('Angular velocity $\dot{\theta_1}, \dot{\theta_3}$ (deg/s)','interpreter','latex')
   set(gca,'fontsize',36, 'fontname', 'Euclid')
end
end
% xlabel('deg');
% ylabel('deg/s')

%%
% figure()
% plot(t,(q(:,1)-pi)*180/pi,t,q(:,2)*180/pi,t,q(:,3)*180/pi)
% xlabel('time (s)');
% ylabel('\theta (deg)')
% legend('Transfemoral hip','Knee','Able hip');
%close all
           %   Display1_4degincline(q,t,P1,Q1) % for video
              Display1_4degincline2(q,t,P1,Q1) % for stick diagram
%%
% savecg(end)-x0
% for j=1:length(P1_ground)
% DBM(j)=sqrt(0^2+(P1_ground(j)-savezmp(j))^2);
% end
% figure
%    plot(t(1:length(DBM)),DBM)
%    xlabel('time(s)')
%    ylabel('DBM(m)')
% %    
%%
% for i=1:a
%     
% X=q(i,:);
% clf
% hold on
% %     line([-5 0.5],[0 0],'LineWidth',2,'Color','b');
% 
% x1=P1(i);
% %   y1=zeros(length(x1),1);
%   m=tand(0);
% %   y1=-m.*x1;
%  y1=Q1(i);
% th1=X(1);
% th2=X(2);
% th3=X(3);
% x2=x1+l(1)*sin(X(1))/2;
% y2=y1-l(1)*cos(X(1))/2;
% x3=x1+l(1)*sin(X(1));
% y3=y1-l(1)*cos(X(1));
% x4=x3+l(2)*sin(X(2));
% y4=y3-l(2)*cos(X(2));
% x5=x4+l(3)*sin(X(3));
% y5=y4-l(3)*cos(X(3));
% savex1 = [savex1 x1];
% savex2 = [savex2 x2];
% savex3 = [savex3 x3];
% savex4 = [savex4 x4];
% savex5 = [savex5 x5];
% savey1 = [savey1 y1];
% savey2 = [savey2 y2];
% savey3 = [savey3 y3];
% savey4 = [savey4 y4];
% savey5 = [savey5 y5];
% saveth1=[saveth1 th1];
% saveth2=[saveth2 th2];
% saveth3=[saveth3 th3];
%     X1=x2;Y1=y2;
%     X2=(x3+x4)/2;Y2=(y3+y4)/2;
%     X3=(x4+x5)/2;Y3=(y4+y5)/2;
%     saveX1 = [saveX1 X1];
%     saveX2 = [saveX2 X2];
%     saveX3 = [saveX3 X3];
%     saveY1 = [saveY1 Y1];
%     saveY2 = [saveY2 Y2];
%     saveY3 = [saveY3 Y3];
% 
% end
% time=transpose(t);
% DX1=diff(saveX1)./diff(time);
% DDX1=diff(DX1)./diff(time(1:length(t)-1));
% DX2=diff(saveX2)./diff(time);
% DDX2=diff(DX2)./diff(time(1:length(t)-1));
% DX3=diff(saveX3)./diff(time);
% DDX3=diff(DX3)./diff(time(1:length(t)-1));
% DY1=diff(saveY1)./diff(time);
% DDY1=diff(DY1)./diff(time(1:length(t)-1));
% DY2=diff(saveY2)./diff(time);
% DDY2=diff(DY2)./diff(time(1:length(t)-1));
% DY3=diff(saveY3)./diff(time);
% DDY3=diff(DY3)./diff(time(1:length(t)-1));
% Dth1=diff(saveth1)./diff(time);
% DDth1=diff(Dth1)./diff(time(1:length(t)-1));
% Dth2=diff(saveth2)./diff(time);
% DDth2=diff(Dth2)./diff(time(1:length(t)-1));
% Dth3=diff(saveth3)./diff(time);
% DDth3=diff(Dth3)./diff(time(1:length(t)-1));
% ab=length(DDX1);
