
% filtrageBilaterale Filtrage bilateral 2D.
% 
     %Algorithme a voir dans l'article suivant :
%       C. Tomasi and R. Manduchi. Bilateral Filtering for 
%       Gray and Color Images. 

%    reponse = filtrageBilaterale(A,W,SIGMA) 
%    
%  A= image en entrée doit être une matrice a double précision
% de la taille ou la NxMx1 NxMx3 (ie, niveaux de grisImages ou couleur
%, respectivement) avec des valeurs normalisées dans l'intervalle fermé [0,1]
% 
%  w = La demi-taille de la Fenêtre de gaussienne du filtre  bilatéral est
%
% Les normes de Déviations du filtre bilatérale sont donnés par =
%  SIGMA = SIGMA(1) pour l'écart-type du domaine spatiale 
%  SIGMA = SIGMA(2) pour déviation standard intensité du domaine 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



function reponse = filtrageBilaterale(A,w,sigma)

% Verification de l'éxistence de l'image et de sa validité
if ~exist('A','var') || isempty(A)
   error('Image d''entrée A invalide');
end
if ~isfloat(A) || ~sum([1,3] == size(A,3)) || ...
      min(A(:)) < 0 || max(A(:)) > 1
   error(['Image d''entrée A doit être a double precision ',...
          'matrice  de taille NxMx1(niveau de gris) or NxMx3(RGB) dans  ',...
          'intervale [0,1].']);      
end

% Verification de la taille de fenetre du filtre bilateral.
if ~exist('w','var') || isempty(w) || ...
      numel(w) ~= 1 || w < 1
   w = 5;
end
w = ceil(w);

% Verification des déviations ou décalage Ws standard du filtre bilateral.
if ~exist('sigma','var') || isempty(sigma) || ...
      numel(sigma) ~= 2 || sigma(1) <= 0 || sigma(2) <= 0
   sigma = [3 0.1];
end

% Applique le filtrage bilaterale ou bien a l'image en niveau de gris 
% ou bien couleur.
if size(A,3) == 1
   reponse = bfltGray(A,w,sigma(1),sigma(2));
else
   reponse = bfltColor(A,w,sigma(1),sigma(2));
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Implementation du Filtrage Bilatérale pour l'image en niveau de gris.
function reponse = bfltGray(A,w,sigma_d,sigma_r)

% Pre-calcul  de la distance Gaussienne des poids.
[X,Y] = meshgrid(-w:w,-w:w); % je fais ici un meshgrid sur une fentre [-w,+w]
G = exp(-(X.^2+Y.^2)/(2*sigma_d^2)); %puis je calcul la geussienne

% Creation d'un waitbar.
h = waitbar(0,'Application du filtrage bilaterale ...');
set(h,'Name','Filtrage Bilaterale en progression... veuillez patientez SVP');

% Application du filtrage bilateral.
dim = size(A);
reponse = zeros(dim);
for i = 1:dim(1)
   for j = 1:dim(2)
      
         % Extraction du voisinage local I.
         iMin = max(i-w,1);
         iMax = min(i+w,dim(1));
         jMin = max(j-w,1);
         jMax = min(j+w,dim(2));
         I = A(iMin:iMax,jMin:jMax);
      
         % Calcul des poids de l'intensité Gaussienne.
         H = exp(-(I-A(i,j)).^2/(2*sigma_r^2));
      
         % Calcul de la réponse du filtrage bilateral.
         F = H.*G((iMin:iMax)-i+w+1,(jMin:jMax)-j+w+1);
         reponse(i,j) = sum(F(:).*I(:))/sum(F(:));
               
   end
   waitbar(i/dim(1));
end

% Fermeture de la waitbar.
close(h);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Implementation du filtre  bilaterale pour les images couleurs.
function reponse = bfltColor(A,w,sigma_d,sigma_r)

% Convertion de l'image RGB en entrée en  CIELab color space (espace couleur).
if exist('applycform','file')
   A = applycform(A,makecform('srgb2lab'));
else
   A = colorspace('Lab<-RGB',A);
end

% Pre-calcul des poids du domaine Gaussien.
[X,Y] = meshgrid(-w:w,-w:w);% j'utilise ici une fonction de matlab pour les mailles
G = exp(-(X.^2+Y.^2)/(2*sigma_d^2));% j'applique la guassienne 

% recalage de la variance (en utilisant une luminance
% maximum).
sigma_r = 100*sigma_r;

% Creation d'une waitbar.
h = waitbar(0,'Applying bilateral filter...');
set(h,'Name','Bilateral Filter Progress');

% Appliquation du filtrage  bilaterale.
dim = size(A);
reponse = zeros(dim);
for i = 1:dim(1)
   for j = 1:dim(2)
      
         % Extraction du voisinage locale.
         iMin = max(i-w,1);
         iMax = min(i+w,dim(1));
         jMin = max(j-w,1);
         jMax = min(j+w,dim(2));
         I = A(iMin:iMax,jMin:jMax,:);
      
         % Calcule des poids de la distance Gaussienne.
         dL = I(:,:,1)-A(i,j,1);
         da = I(:,:,2)-A(i,j,2);
         db = I(:,:,3)-A(i,j,3);
         H = exp(-(dL.^2+da.^2+db.^2)/(2*sigma_r^2));
      
         % Calcule de la réponse du filtre bilaterale.
         F = H.*G((iMin:iMax)-i+w+1,(jMin:jMax)-j+w+1);
         norm_F = sum(F(:));
         reponse(i,j,1) = sum(sum(F.*I(:,:,1)))/norm_F;
         reponse(i,j,2) = sum(sum(F.*I(:,:,2)))/norm_F;
         reponse(i,j,3) = sum(sum(F.*I(:,:,3)))/norm_F;
                
   end
   waitbar(i/dim(1));
end

% Reconvertion de l'image filteré en image sRGB color space.
if exist('applycform','file')
   reponse = applycform(reponse,makecform('lab2srgb'));
else  
   reponse = colorspace('RGB<-Lab',reponse);
end

% Fermeture de la  waitbar.
close(h);