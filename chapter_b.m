clear all
clc
format longG

%Arxikopoihsh Xronou
t=0:0.1e-5:5;

%Dimiourgia pinakwn gia apothikeusi dedomenwn
vc_array = zeros(10,1);
vr_array = zeros(10,1);

%Anaktisi dedomenwn apo v.p gia VR kai VC
for i=1:length(t)
    if t(i)==0.01
        Vout=v(t(i));
        VR=Vout(2);
        vr_array(i,1)=VR;
        VC=Vout(1);
        vc_array(i,1)=VC;
    elseif t(i)==0.1
        Vout=v(t(i));
        VR=Vout(2);
        vr_array(i,1)=VR;
        VC=Vout(1);
        vc_array(i,1)=VC;
    elseif t(i)==1
        Vout=v(t(i));
        VR=Vout(2);
        vr_array(i,1)=VR;
        VC=Vout(1);
        vc_array(i,1)=VC;
    else
        Vout=v(t(i));
        VR=Vout(2);
        vr_array(i,1)=VR;
        VC=Vout(1);
        vc_array(i,1)=VC;
    end

end

%Graphikes synartisei tou xronoy gia VR kai VC
figure
plot(t,vr_array)
hold on
plot(t,vc_array)
legend({'Vr', 'Vc'});
ylabel('V (V)')
xlabel('Time (s)')
title('Metriseis Vr kai Vc synartisei tou xronou');
hold off

%Diadikasia gia na parw tis metriseis tis u1 afou u2=const
u1_array = zeros(10,1);
for i=1:length(t)
    u1 = 2*sin(t(i));
    u1_array(i,1) = u1; 
end
u2=ones(length(t),1);

%Dimiourgia pinaka phi
phi=zeros(length(t),6);
p1=100;
p2=100;
phi1=lsim(tf([-1 0],[1 (p1+p2) (p1*p2)]),vc_array,t);
phi2=lsim(tf(-1,[1 (p1+p2) (p1*p2)]),vc_array,t);
phi3=lsim(tf([1 0],[1 (p1+p2) (p1*p2)]),u1_array,t);
phi4=lsim(tf(1,[1 (p1+p2) (p1*p2)]),u1_array,t);
phi5=lsim(tf([1 0],[1 (p1+p2) (p1*p2)]),u2,t);
phi6=lsim(tf(1,[1 (p1+p2) (p1*p2)]),u2,t);

phi(:,1)=phi1;
phi(:,2)=phi2;
phi(:,3)=phi3;
phi(:,4)=phi4;
phi(:,5)=phi5;
phi(:,6)=phi6;

%Sximatismos pinaka theta_0
A = phi'*phi;
B = vc_array'*phi;
theta = A\B';

% Evresi twn logwn 1/RC kai 1/LC
logoi = theta+[p1+p2; p1*p2; 0; 0; 0; 0]
logos_RC = [logoi(1,1); logoi(3,1); logoi(5,1)];
logos_LC = [logoi(2,1); logoi(6,1)];

global logos_RC_final logos_LC_final

logos_RC_final = (logoi(1,1)+logoi(3,1)+logoi(5,1))/3
logos_LC_final = (logoi(2,1)+logoi(6,1))/2

%Evresi me Vr 
T =0:0.1e-5:5;
[t, y] = ode45(@fun, T, [0 0]);
Vc_neo = y(:,1);
Vr_neo = u1_array+u2-Vc_neo;

figure
plot(t,Vr_neo)
hold on
plot(t,Vc_neo)
legend({'Vr', 'Vc'});
ylabel('V (V)')
xlabel('Time (s)')
title('Metriseis Vr kai Vc synartisei tou xronou me ode');
hold off

figure
plot(t,vc_array)
hold on
plot(t,Vc_neo)
legend({'Vc', 'Vc neo'});
ylabel('V (V)')
xlabel('Time (s)')
title('Sygrusi metaksi Vc apo v.p kai Vc neo');
hold off

figure
plot(t,vr_array)
hold on
plot(t,Vr_neo)
legend({'Vr', 'Vr neo'});
ylabel('V (V)')
xlabel('Time (s)')
title('Sygrusi metaksi Vr apo v.p kai Vr neo');
hold off

figure
plot(t,vr_array-Vr_neo)
legend({'diff'});
ylabel('V (V)')
xlabel('Time (s)')
title('Diakimansi diaforas Vr synartisei tou xronou');

figure
plot(t,vc_array-Vc_neo)
legend({'diff'});
ylabel('V (V)')
xlabel('Time (s)')
title('Diakimansi diaforas Vc synartisei tou xronou');


%Synartisi odefun gia thn dimioyrgia ths diaforikis tou Vc
function dydt = fun(t,y)
    global logos_RC_final logos_LC_final
    u1 = 2*sin(t);
    u1_dot=2*cos(t);
    u2=1;
    u2_dot=0;
    dydt = [y(2); 
             -logos_RC_final*y(2)-logos_LC_final*y(1)+logos_RC_final*u1_dot+logos_RC_final*u2_dot+logos_LC_final*u2];
end

