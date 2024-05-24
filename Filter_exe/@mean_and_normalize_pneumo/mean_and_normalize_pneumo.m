function [ s1 ] = mean_and_normalize_pneumo( s1);
% mittelwertbefreien und normieren der Daten
s1 = (s1*3.3)/4096;     % Spannung
s1 = s1-mean(s1);       % mittelwertbefreien
s1 = s1.*(1/max(s1));   % normieren
end

