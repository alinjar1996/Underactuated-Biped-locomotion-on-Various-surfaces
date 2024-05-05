clear all;clc;close all;



global k kd j phi;

global saveX1 saveX2 saveX3 saveY1 saveY2 saveY3 savex1 savex2 savex3 savex4 savex5 savey1 savey2 savey3 savey4 savey5 savezmp saveth1 saveth2 saveth3 savecg saveAB q0 saveA saveB An fn Tn savephi saveTD
saveX1 = [];saveX2= [];saveX3= [];saveY1= [];saveY2= [];saveY3= [];savecg=[];savephi=[];saveTD=[];
savex1 = [];savex2= [];savex3= [];savex4= [];savex5= [];savey1= [];savey2= [];savey3= [];savey4= [];savey5= [];savezmp=[];saveth1=[];saveth2=[];saveth3=[];saveAB=[];saveA=[];saveB=[];
  k =6;
 An=0;fn=0.77;
 Tn=(1/fn);
 phi=0;
 %kd=0; %flat_surface
 %  kd=1;%2 degree inclined plane
      % kd=1.2;%4 degree inclined plane
      kd =1.0; %worked
     % kd = 0.7;
%  kd=1.2;
  
% k=6; %curved feet
q01 = -0.14+pi;
    %q0 = [q01;pi-q01;pi-q01;7.53*(pi-q01);0;0];%normalfeet
    q0 = [q01;pi-q01;pi-q01;7.53*(pi-q01);0;0];%normalfeet

% k = 8;
% q01 = -0.11+pi;
% q0 = [q01;pi-q01;pi-q01;6*(pi-q01);0;0];

% k = 9;
% q01 = -0.1+pi;
% q0 = [q01;pi-q01;pi-q0a1;6*(pi-q01);0;0];

% k = 9.2;
% q01 = -0.096+pi;
% q0 = [q01;pi-q01;pi-q01;6*(pi-q01);0;0];


n = 10-0*1;% no of cycles
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

if j>4 && j<6

   % k = 8-1*3;

    k = 8-1*4;

    kd = 1.9 - 1*0.05 - 4*0.05;

elseif j>5 && j<8

    k = 8-1*4 - 0;

    kd = 1.5-5*0.05 - 0*0.05;

elseif j>8 && j<10

    k = 3;

    kd = 1.2 - 4*0.1;

elseif j ==10

    k = 3.5;

    kd = 0.7;

end    


q1dot =[];
for jj =1:length(t1)
      
      if jj == 1
      
      D(jj) = 0;

      else

      D(jj)= t1(jj)-t1(jj-1);  
      end
      
      q1dot(jj,:)=odefun1(t1(jj),q1(jj,:));

      Thip1(jj,:) = abs((k*q1(jj,3)+kd*q1(jj,6))*q1(jj,4)*D(jj));
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
options2 = odeset('Events',@groundimpact_circleincline);%,'MaxStep',2.5000e-05);
[t2,q2] = ode45(@odefun2,tspan,q0,options2);

q2dot =[];
 for kk =1:length(t2)
    
     q2dot(kk,:)=odefun2(t2(kk),q2(kk,:));

     Thip2(kk,:) = 0;
 
 end

t = [t;t1;t2];q=[q;q1;q2]; Thip =[Thip;Thip1;Thip2]; qdot=[qdot;q1dot;q2dot];

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

%limit cycle
if j == n -1
%     temp =[2*pi-q0(1) q0(2) -q0(3) q0(6) q0(5) q0(4)];
    temp =[pi+q0(3) q0(2) q0(1)-pi q0(6) q0(5) q0(4)];
    tt = [t1;t2];qq=[q1;q2;temp];
    figure()
   hold on
   graph1=plot(qq(:,3)*180/pi,qq(:,6)*180/pi);
    graph2 = plot(qq(:,1)*180/pi-180,qq(:,4)*180/pi);
        set(graph1,'LineWidth',2);
     set(graph2,'LineWidth',2);
legend('\beta_3','\beta_1') 
  xlabel(' $\beta_1-180 , \beta_3$ (deg)',  'interpreter','latex')
   ylabel(' $\dot{\beta_1}, \dot{\beta_3}$ (deg/s)','interpreter','latex')
   set(gca,'fontsize',40, 'fontname', 'Euclid')
   
end
end
% xlabel('deg');
% ylabel('deg/s')

%%
          
    Display1_circleincline(q,t,P1,Q1) %for stick diagram

  %  Display1_circleincline_video(q,t,P1,Q1) %for video

           %Display1_circleroc8(q,t,P1,Q1) %for video
