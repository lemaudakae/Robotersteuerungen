function P = Interpolation(P_start, P_soll, steps)
% lineare Interpolation der Position im kartesischen Raum
% P_start P_soll 3x1
% P Nx3
    t = (0:1/steps:1)';
    P = repmat(P_start',length(t),1) + t*(P_soll'-P_start');

end