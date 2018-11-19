function out = IK_Pseudo(q_ist,position_soll)
q_soll = q_ist;
dqMax = 0.0001; % Maximale Änderung eines Gelenkwinkels -> sonst Fehlermeldung
eMaxPosition = 0.01; % Maximale Positionsfehler im kartesischen Raum -> sonst Fehlermeldung

%% Do 128 iterations to estimate the inverse kinematic
for i=0:2
    % Get jacobian for position. This function should be programmed in the
    % task before
    % Caution: Rad/Degree!
    % J = Jacobi_Matrix(q);
    
    % Get transformation matrix
    % Caution: Rad/Degree!
    % T = TransformationsMatrix(q);
    
    T = TransformationsMatrix(q_soll);
    J_pose = JacobiMatrix(T);
    J_position = J_pose(1:3,:,:);   
    
    % Calculate the error
    e_position = position_soll' - T(1:3,4,6);
  
    % Calculation step with pseudo inverse jacobian
    q_soll = q_soll + J_position'/(J_position*J_position')*e_position;
    
end

if max(q_ist - q_soll) > dqMax 
    disp('zu großer Sprung im Gelenkraum')
    dq = q_ist - q_soll
end

if max(abs(e_position)) > eMaxPosition
    %sprintf('Positionsfehler zu groß \nx: %f \ny: %f \nz: %f',e_position(1),e_position(2),e_position(3))
    disp('Positionsfehler zu groß')
    e_position = e_position
end

out = q_soll;
end