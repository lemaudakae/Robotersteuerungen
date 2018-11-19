%% 2 a)
P_start = [0 0 0];
P_soll = [1 1 1];
Zwischenschritte = 10;
P = Interpolation(P_start, P_soll, Zwischenschritte);
plot3(P(:,1),P(:,2),P(:,3),'*-');
grid on

%% 2 c)

P_start = [0 0 0];
P_soll = [1 1 1];
v = 2;
a = 3;
P = P_Interp(P_start, P_soll, v, a);
plot3(P(:,1),P(:,2),P(:,3),'*-');
grid on

%% 2 d)

fileID = fopen('Trajektorie.txt','w');
for i = 1:length(P)
    fprintf(fileID,'%f %f %f\n',P(i,1),P(i,2),P(i,3));
end

