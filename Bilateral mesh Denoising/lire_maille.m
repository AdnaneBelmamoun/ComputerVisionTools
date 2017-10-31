function [sommet,face] = lire_maille(fichier)

% read_mesh - lecture des données depuis fichier, PLY, SMF or WRL.
%
%   [vertex,face] = read_mesh(filename);
%
%   'sommet' est le 'nb.sommet x 3' tableau qui specifie la position ds sommets.
%   'face' is a 'nb.face x 3'  tableau qui specifie la connéctivité de la maille.
%
%  

ext = fichier(end-2:end);
ext = lower(ext);
if strcmp(ext, 'off')
    [sommet,face] = read_off(fichier);
elseif strcmp(ext, 'ply')
    [sommet,face] = read_ply(fichier);
elseif strcmp(ext, 'smf')
    [sommet,face] = read_smf(fichier);
elseif strcmp(ext, 'wrl')
    [sommet,face] = read_wrl(fichier);
else
    error('extension inconnue.');    
end

