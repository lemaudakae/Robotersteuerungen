function P = P_Interp(P_start, P_soll, v , a)
% lineare Interpolation der Position im kartesischen Raum mit
% Geschwindigkeits und Beschleunigungsberücksichtigung
% P_start P_soll 3x1
% P Nx3

    t_sample = 0.01; % Abtastzeit in s

    % Gesamtweg
    p_ges = norm(P_start-P_soll);
    
    % Beschleunigungs-/Abbremszeit
    t_acc = v/a; t_dec = t_acc;
    
    % Beschleunigungs-/Abbremsweg
    p_acc = 0.5*a*t_acc^2; p_dec = p_acc;
    
    % Nullbeschleunigungsweg/-zeit
    t_null = (p_ges-p_acc-p_dec)/v;
    p_null = t_null*v;
    
    % Sonderfall kurze Distanzen
    if t_null<0
        t_acc = t_acc + 0.5*t_null; t_dec = t_acc;
        t_null = 0;
        v = a*t_acc;
        
        % Beschleunigungs-/Abbremsweg
        p_acc = 0.5*a*t_acc^2; p_dec = p_acc;
        
        % Nullbeschleunigungsweg
        p_null = 0;
    end
    
    % Zeitvektor + prealloc
    t_sum = t_acc + t_dec + t_null;    
    t_vec = 0:t_sample:t_sum;
    P = zeros(1,length(t_vec));
    
    % Sampeln
    for i=1:length(t_vec)
       t = t_vec(i);
       if t<t_acc % Beschleunigungsphase
           P(i) = 0.5*a*t^2; 
       elseif t<t_acc+t_null % Nullbeschleunigungsphase
           P(i) = p_acc + v*(t-t_acc);
       else % Abbremsphase
           P(i) = p_acc + p_null + v*(t-t_acc-t_null) - 0.5*a*(t-t_acc-t_null)^2;
       end
    end
    
    % Endpunkt einfügen, wenn dieser nicht genau erreicht wurde
    P(end+1) =  p_ges;
    
    % In 3D umrechnen
    P = repmat(P_start',length(P),1) + P'*((P_soll'-P_start')./p_ges);
    
end