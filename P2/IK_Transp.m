function out = IK_Transp(q_ist,position_soll)
q = q_ist;


%% Do 128 iterations to estimate the inverse kinematic
for i=0:127
    % Get jacobian for position. This function should be programmed in the
    % task before
    % Caution: Rad/Degree!
    % J = Jacobi_Matrix(q);
    
    T = TransformationsMatrix(q);
    J_pose = JacobiMatrix(T);
    J_position = J_pose(1:3,:,:);   
    
    % Calculate the error
    e_position = position_soll' - T(1:3,4,6);
  
    % Calculation step with pseudo inverse jacobian
    q = q + J_position'*e_position;
    
end

out=q;
end