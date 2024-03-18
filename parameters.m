% defining parameters 
%normal feet
m1 = 4;m2 = 2; m3 = 2;
r=0;
l = [0.8 0.4 0.4];
a=[0.4 0.2 0.2];
I1 = 0.21; I2 = 0.027;I3=0.027;
G = 0.15;%for normal feet
% % curved feet
% r=0.3;
% m1=2.2;m2=1.6;m3=0.6;
% l = [0.64 0.32 0.32];
% a =[0.41 0.13 0.16];
% I1 = 0.0880; I2 = 0.0294;I3=0.0052;
% G=0.033;%for curved feet
g = 9.81;
a1=a(1);
a2=a(2);
a3=a(3);
l1=l(1);
l2=l(2);
l3=l(3);
% alpha=10*pi/180;%for_inclined_plane

% m1=.145+.618;   % mass of 1 leg (= mass of thigh + mass of shank)
% m2=0.618;       % mass of thigh
% m3=0.145;       % mass of shank
% l(1)=0.3;         % leg length (from support point to hip joint)
% l(2)=0.15;        % thigh length (hip joint to knee joint)
% l(3)=0.15;        % shank length (support point to knee joint)
% a(1)=0.2002;      % distance of CG of whole leg from support point along the length of leg
% a(2)=0.0228;      % distance of CG of Thigh from hip joint
% a(3)=0.0648;      % distance of CG of shank from knee joint
% I3=6.06e-4;     % moment of inertia of a leg about axis through hip joint
% I2=3.145e-3;    % moment of inertia of thigh about axis through hip joint
% I1=6.12e-3;     % moment of inertia of shank about axis through knee joint
% 
% yo=.14;
% dyo=7.53*yo;
% q0=[pi-yo yo yo dyo 0 0];