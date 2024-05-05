function [] = Display1_circleincline_video(q,t,P1,Q1)
%global savex1 savex2 savex3 savex4 savex5 savey1 savey2 savey3 savey4 savey5 
global saveX1 saveX2 saveX3 saveY1 saveY2 saveY3 savex1 savex2 savex3 savex4 savex5 savey1 savey2 savey3 savey4 savey5 savezmp saveth1 saveth2 saveth3 savecg m
%figure('units','normalized','outerposition',[0 0 1 1])
reruns=1;                  % number of times movie is to play
fps=18;                    % frames per second

parameters
global DDth1 DDth2 DDth3
% writerObj = VideoWriter('D:\phd progress report\self-excited biped\video_k9');
% open(writerObj);

a = length(q);


for i=1:a
    
X=q(i,:);
clf
xllim = -2.5-0.5;
hold on
 %   line([-5 0.5],[0 0],'LineWidth',2,'Color','b'); %original for full   walk
  line([xllim 0.5],[0 0],'LineWidth',2,'Color','b');

x1=P1(i);
%   y1=zeros(length(x1),1);
%   m=tand(-4);
%   y1=-m.*x1;
 y1=Q1(i);
th1=X(1);
th2=X(2);
th3=X(3);
x2=x1+l(1)*sin(X(1))/2;
y2=y1-l(1)*cos(X(1))/2;
x3=x1+l(1)*sin(X(1));
y3=y1-l(1)*cos(X(1));
x4=x3+l(2)*sin(X(2));
y4=y3-l(2)*cos(X(2));
x5=x4+l(3)*sin(X(3));
y5=y4-l(3)*cos(X(3));
savex1 = [savex1 x1];
savex2 = [savex2 x2];
savex3 = [savex3 x3];
savex4 = [savex4 x4];
savex5 = [savex5 x5];
savey1 = [savey1 y1];
savey2 = [savey2 y2];
savey3 = [savey3 y3];
savey4 = [savey4 y4];
savey5 = [savey5 y5];
saveth1=[saveth1 th1];
saveth2=[saveth2 th2];
saveth3=[saveth3 th3];
    X1=x2;Y1=y2;
    X2=(x3+x4)/2;Y2=(y3+y4)/2;
    X3=(x4+x5)/2;Y3=(y4+y5)/2;
    saveX1 = [saveX1 X1];
    saveX2 = [saveX2 X2];
    saveX3 = [saveX3 X3];
    saveY1 = [saveY1 Y1];
    saveY2 = [saveY2 Y2];
    saveY3 = [saveY3 Y3];

end
time=transpose(t);
DX1=diff(saveX1)./diff(time);
DDX1=diff(DX1)./diff(time(1:length(t)-1));
DX2=diff(saveX2)./diff(time);
DDX2=diff(DX2)./diff(time(1:length(t)-1));
DX3=diff(saveX3)./diff(time);
DDX3=diff(DX3)./diff(time(1:length(t)-1));
DY1=diff(saveY1)./diff(time);
DDY1=diff(DY1)./diff(time(1:length(t)-1));
DY2=diff(saveY2)./diff(time);
DDY2=diff(DY2)./diff(time(1:length(t)-1));
DY3=diff(saveY3)./diff(time);
DDY3=diff(DY3)./diff(time(1:length(t)-1));
Dth1=diff(saveth1)./diff(time);
DDth1=diff(Dth1)./diff(time(1:length(t)-1));
Dth2=diff(saveth2)./diff(time);
DDth2=diff(Dth2)./diff(time(1:length(t)-1));
Dth3=diff(saveth3)./diff(time);
DDth3=diff(Dth3)./diff(time(1:length(t)-1));
ab=length(DDX1);
% pause(10)
figure
for k=1:ab/4
  % p=linspace(-pi/6,0/4,1000);
   r=8;
   %xx=linspace(0,xllim,10000);
   xlim1 = -1;
   xx1 = linspace(0,xlim1,5000);
   xx2 = linspace(xlim1, xllim,5000);

%    yy1 = zeros(1,5000);
%    yy2 = zeros(1,5000);

   yy1 = -r + sqrt(r^2-xx1.^2);

%    size(xx1)
% 
%    size(yy1)
% 
%    size(yy2)
   m = tand(4);
   yy2 = m.*xx2- 0*0.03;

   plot(xx1,yy1, 'Linewidth', 1.5)
   hold on
   plot(xx2,yy2, 'Linewidth', 1.5)
   hold on
  % yy=r*cos(p)-r;
  % xx=r*sin(p);
  % plot(xx,yy)
% xx=linspace(0,-5,1000);
% yy=.1*(cos(1.5*xx)-1);
% plot(xx,yy)
% axis('equal')
% if k> 5
%  j = 8*(k-5);
% else
 j = 4*k;
%end
%m = tand(4);
% xx=linspace(0,xllim,10000);%for inclined plane
% 
% yy= m.*xx; %for inclined plane 
% % 
%plot(xx,yy)

axis('equal')
%   axis([-2 2 0 1])

% hold off
%   animation=  plot([savex1(j) savex2(j) savex3(j) savex4(j) savex5(j)],[savey1(j) savey2(j) savey3(j) savey4(j) savey5(j)])
%    set(animation,'LineWidth',2);

 %    hold off % to be changed
   L1=line([savex1(j) savex2(j)],[savey1(j) savey2(j)],'Color',[0 0 1],'LineWidth',3);
   L2=line([savex2(j) savex3(j)],[savey2(j) savey3(j)],'Color',[0 0 1],'LineWidth',3);
   L3=line([savex3(j) savex4(j)],[savey3(j) savey4(j)],'Color',[1 0 0],'LineWidth',2);
   L4=line([savex4(j) savex5(j)],[savey4(j) savey5(j)],'Color',[1 0 0],'LineWidth',2);
    P=[saveX1(j) saveY1(j)];
    Q=[saveX2(j) saveY2(j)];
    R=[saveX3(j) saveY3(j)];
%     xlabel('Time','fontweight','bold','fontsize',16);
    xlabel('x','fontweight','bold','fontsize',28,'fontname', "Euclid");
  %  ylabel('Z','fontweight','bold','fontsize',20,'fontname', "Euclid")
    ylabel('y','fontweight','bold','fontsize',28,'fontname', "Euclid")

   set(gca,'FontSize',36, 'fontname', "Euclid")

%   global k

 % title('initial hip joint velocity'= num2str(q(1,4)),'Feedback Gain = ',k);
 %  title('Feedback Gain = ',k)

%      zmp(j)=m1*((DDY1(j)+g)*saveX1(j)-(saveY1(j))*DDX1(j))+m2*((DDY2(j)+g)*saveX2(j)-(saveY2(j))*DDX2(j))+m3*((DDY3(j)+g)*saveX3(j)-(saveY3(j))*DDX3(j))/(m1*(DDY1(j)+g)+m2*(DDY2(j)+g)+m3*(DDY3(j)+g))
zmpnumerator(j)=(m1*(DDY1(j)-g)*saveX1(j)+m2*(DDY2(j)-g)*saveX2(j)+m3*(DDY3(j)-g)*saveX3(j))-(m1*DDX1(j)*saveY1(j)+m2*DDX2(j)*saveY2(j)+m3*DDX3(j)*saveY3(j))-(I1*DDth1(j)+I2*DDth2(j)+I3*DDth3(j));
zmpdenominator(j)=m1*(DDY1(j)-g)+m2*(DDY2(j)-g)+m3*(DDY3(j)-g);
zmp(j)=zmpnumerator(j)/zmpdenominator(j);
cg(j)=(m1*saveX1(j)+m2*saveX2(j)+m3*saveX3(j))/(m1+m2+m3);
% axis([-2 5 -2 2])
%  axis([-4 2 -0 1])
% A=viscircles(P,0.01);
% B=viscircles(Q,0.01);
% C=viscircles(R,0.01);
%  ZMP=viscircles([zmp(j) 0],0.01);
%  GCOM=viscircles([cg(j) 0],0.01);
% viscircles(P,0.01);
% viscircles(Q,0.01);
% viscircles(R,0.01);
% drawnow
pause(0.01) 
hold off
if j<ab
%         delete(L1);
%         delete(L2);
%         delete(L3);
%         delete(L4)
%         delete(ZMP);
end

% zmp=m1.*((DDY1+g).*saveX1(1:a)-(saveY1(1:a)).*DDX1(1:a))+m2.*((DDY2(1:a)+g).*saveX2(1:a)-(saveY2(1:a)).*DDX2(1:a))+m3*((DDY3(1:a)+g).*saveX3(1:a)-(saveY3(1:a)).*DDX3(1:a))/(m1.*(DDY1(1:a)+g)+m2.*(DDY2(1:a)+g)+m3.*(DDY3(1:a)+g))

% axis equal %to be kept in original
%    axis([-0.5 0.5 0 1])

end
savezmp=[savezmp zmp];
savecg=[savecg cg];
end
