%% 2 a)
P_start = [0 0 0]';
P_soll = [1 1 1]';
Zwischenschritte = 10;
P = Interpolation(P_start, P_soll, Zwischenschritte);
plot3(P(:,1),P(:,2),P(:,3),'*-');
grid on

%% 2 c) d)
close all;
% kartesische Startposition des Roboters anhand der Gelenkwinkel bestimmen
% q_start = [0 0 0 0 0 0]';
q_start = [0.1 0.1 0.1 0.1 0.1 0.1]';
T = TransformationsMatrix(q_start);
P_start = T(1:3,4);
% P_start = [0 0 0];

% kartesische Zielposition
P_soll = P_start + [0.2; 0.2; 0.2];
% P_soll = [1 1 1];

% max. Beschleunigung & Geschwindigkeit im kartesischen Raum
% v = 0.1;
v = 5;
a = 3;

% Generation Trajektorie und direkter Plot 
P = P_Interp(P_start, P_soll, v, a);
% 3D
plot3dhandle = figure;
plot3(P(:,1),P(:,2),P(:,3),'*-','DisplayName','direkt berechnet');
grid on
% Koordinaten
figure
subplot(3,1,1)
plot((1:length(P))/100,P(:,1),'DisplayName','x')
xlabel('Zeit in s')
ylabel('Position in m')
legend;
subplot(3,1,2)
plot((1:length(P))/100,P(:,2),'DisplayName','y')
xlabel('Zeit in s')
ylabel('Position in m')
legend;
subplot(3,1,3)
plot((1:length(P))/100,P(:,3),'DisplayName','z')
xlabel('Zeit in s')
ylabel('Position in m')
legend;

%% Inverse Kinematik berechnen und Plot
Q = [q_start'; zeros(length(P)-1,6)];
for i=1:length(P)-1
    Q(i+1,:) = IK_Pseudo(Q(i,:)',P(i+1,:)')';
end

figure
hold on
for i=1:6
    plot((1:length(Q))/100,Q(:,i),'DisplayName',sprintf('Gelenk %1.0f',i))
end
xlabel('Zeit in s')
ylabel('Gelenkwinkel in rad???')
legend;

%% Direkte Kinematik zur Inversen Kinematik zur Kontrolle berechnen
P_check = zeros(length(Q),3);
for i=1:length(Q)
    T = TransformationsMatrix(Q(i,:)');
    P_check(i,:) = T(1:3,4)';
end

figure(plot3dhandle);
hold on
plot3(P_check(:,1),P_check(:,2),P_check(:,3),'*-','DisplayName','rücktransformiert');
legend;

%% 2 d)

fileID = fopen('Trajektorie.txt','w');
for i = 1:length(P)
    fprintf(fileID,'%f %f %f\n',P(i,1),P(i,2),P(i,3));
end

