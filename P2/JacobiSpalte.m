function out = JacobiSpalte(T_i,T_tcp)
% Calculate the collumn of the jacobian for joint i
% p_i ^= p_i-1; z_i ^= z_i -1; T_i ^= T_i-1
% S. 55 Skript Suchy

z_i = T_i(1:3,3);
p_i = T_i(1:3,4);
p_n = T_tcp(1:3,4);
J = [cross(z_i,(p_n-p_i)); z_i];

out = J;
end