function out = JacobiMatrix(T)
%% Bitte vervollständigen 
% Calculate the jacobian with the transformation matrices
% T should be a 3 dimensional matrix, where e.g. T(:,:,1) ist the
% transformation matrix of the first joint.
% First, calculate each column j_i of the jacobian seperately with the function JacobiSpalte and then add
% them to a matrix J = [j_1 j_2 j_3 ...].

%% Important
% After calculating j_1, please use the negative value of the first column: j_1 = -j_1

out = J;
end