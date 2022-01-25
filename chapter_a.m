clear all
clc
format longG

T = 0:0.1:10;
arxikes_times = [0 0];
[t, y] = ode45(@odefun, T, arxikes_times);
figure
plot(t,y)
legend({'Position', 'Speed'});
ylabel('Position / Speed [m / m/s]')
xlabel('Time [s]')
title('mass-spring-damper system pragmatiko');
%Diadikasia gia na parw tis metriseis tis y
y_array = y(:,1); 
%Diadikasia gia na parw tis metriseis tis u
u_array = zeros(10,1);
for i=1:length(t)
    u = 5*sin(2*t(i,1))+10.5;
    u_array(i,1) = u; 
end

%Sximatismos pinaka phi
p1 = 0.5;
p2 = 0.6;
phi1 = lsim(tf([-1 0],[1 (p1+p2) (p1*p2)]),y_array,t);
phi2 = lsim(tf(-1,[1 (p1+p2) (p1*p2)]),y_array,t);
phi3 = lsim(tf(1,[1 (p1+p2) (p1*p2)]),u_array,t);
phi = zeros(length(t),3);
phi(:,1) = phi1;
phi(:,2) = phi2;
phi(:,3) = phi3;
%Sximatismos pinaka theta_0
A = phi.'*phi;
B = y_array.'*phi;
theta = B/A;
theta_0 = theta.';

%Eksagwgh symperasmatwn gia thn akriveia kai twn proseggistikwn timwn twn
%parametrwn
global b_proseggisi m_proseggisi k_proseggisi
theta_1 = [0.2/15; 2/15; 1/15];
m_proseggisi = 1/(theta_0(3,1));
m_kanoniko = 1/(theta_1(3,1));
b_proseggisi = m_proseggisi*(theta_0(1,1))+m_proseggisi*(p1+p2);
b_kanoniko = m_kanoniko*(theta_1(1,1));
k_proseggisi = m_proseggisi*(theta_0(2,1))+m_proseggisi*(p1*p2);
k_kanoniko = m_kanoniko*(theta_1(2,1));
theta_kanoniko = [b_kanoniko; k_kanoniko; m_kanoniko]
theta_proseggisi = [b_proseggisi; k_proseggisi; m_proseggisi]
error_geniko = ((theta_kanoniko-theta_proseggisi)/theta_kanoniko)*100;
error = error_geniko(:,3)
%Sximatismos graphikis parastasis proseggistikwn timwn 
[t1, y1] = ode45(@odefun2, T, arxikes_times);
figure
plot(t1,y1)
legend({'Position', 'Speed'});
ylabel('Position / Speed [m / m/s]')
xlabel('Time [s]')
title('mass-spring-damper system Proseggistiko');
%Synartisi odefun gia thn dimioyrgia ths diaforikis twn pragmatikwn timwn
function dydt = odefun(t,x)
    u = 5*sin(2*t)+10.5;
    dydt = [x(2); 
             u/15 - (0.2/15)*x(2) - (2/15)*x(1)];
end
%Synartisi odefun2 gia thn dimioyrgia ths diaforikis twn proseggistikwn timwn
function dydt2 = odefun2(t,x)
    u = 5*sin(2*t)+10.5;
    global b_proseggisi m_proseggisi k_proseggisi
    dydt2 = [x(2); 
             u/m_proseggisi  - (b_proseggisi/m_proseggisi)*x(2) - (k_proseggisi/m_proseggisi)*x(1)];
end