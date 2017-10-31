
% chargement des images de test niveau de gris et couleur
% Note: Must be double precision in the interval [0,1].
img1 = double(imread('niveauGRIS.jpg'))/255;
img2 = double(imread('couleur.jpg'))/255;


% Introduction du bruit dans les images
% Note: This will show the benefit of bilateral filtering.
img1 = img1+0.03*randn(size(img1));
img2 = img2+0.03*randn(size(img2));
%codage des images
img1(img1<0) = 0; img1(img1>1) = 1;
img2(img2<0) = 0; img2(img2>1) = 1;

% Configuration des paramétres du filtre bilaterale.
w     = 5;       % Taille de la fenêtre ou du voisinage
sigma = [3 0.1]; % Déviantion standard du filtre sigma_c=3 et sigma_s=0.1

% Application du filtrage bilatérale pour chaque image.
bflt_img1 = filtrageBilaterale(img1,w,sigma);
bflt_img2 = filtrageBilaterale(img2,w,sigma);

% Affichage de l'image niveau de gris initialeen entrée et filtrée en sortie.
figure(1); clf;
set(gcf,'Name','Resultat du filtrage Bilateralr pour image niveaux de gris');
subplot(1,2,1); imagesc(img1);
axis image; colormap gray;
title('Image initiale en entrée');
subplot(1,2,2); imagesc(bflt_img1);
axis image; colormap gray;
title('Resultat du Filtrage Bilaterale');

%  Affichage de l'image couleur initialeen entrée et filtrée en
%  sortie.
figure(2); clf;
set(gcf,'Name','Resultat du filtrage Bilateralr pour image Couleurs RGB');
subplot(1,2,1); imagesc(img2);
axis image; colormap gray;
title('Image initiale en entrée');
subplot(1,2,2); imagesc(bflt_img2);
axis image; title('Resultat du Filtrage Bilaterale');
drawnow;

