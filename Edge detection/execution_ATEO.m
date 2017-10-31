clear all
clc;
im_originale = imread('susan3.jpg');%.\Pictures\GIRL.tiff %granite.bmp  %teapot.gif  %susan2.jpg  %susan3.jpg 

% Traitement anti-probléme des bordures:
im = traitement_bordures(im_originale);

%im = imnoise(im,noiseused); % speckle % poisson

[m,n,nb_gs]= size(im);

% SNR = 25;
%  for gs=1:nb_gs
%   im(:,:,gs) = awgn(double(im(:,:,gs)),SNR,'measured');
%  end
%  %% pré-traitement DU BRUIT  dans images monochromatique bruitées
%     nb_classe=6;
%         for s=1:nb_gs
%         pas = double(max(max(im(:,:,s)))-min(min(im(:,:,s))))/nb_classe;
%           for i =1:m
%               for j = 1:n
%                  if(im(i,j,s)<pas)
%                      im(i,j,s)=1;
%                  end
%                  for k = 2:nb_classe-1
%                    if(im(i,j,s)<k*pas && im(i,j,s)>=(k-1)*pas )
%                      im(i,j,s)=2*k;
%                    end
%                  end
%                  if(im(i,j,s)>(nb_classe-1)*pas)
%                     im(i,j,s)=nb_classe; 
%                  end
%               end
%           end
%         end
 
% paramétres du pré-traitemnt: x==> taille filtre moyenneur.
 %                              y==> nbre de classe pour quantification 
x=5; y=6;

for gs=1:nb_gs
contour_ATEO(:,:,gs) = ADA_TRE_ENT_OPERATOR(im(:,:,gs),x,y);
end
contour_ATEO_inv = inversion_couleur(contour_ATEO);
[contour_canny,tresh] = canny_color(im);


tresh(:)


 
% affichage:
figure;imshow(mat2gray(im_originale(:,:)));title('Image originale ');
figure;imshow(mat2gray(contour_ATEO_inv));title('Contour Avec Operateur ATEO (Fond Blanc) ');
figure;imshow(mat2gray(contour_ATEO));title('Contour Avec Operateur ATEO(Fond Noir)');
figure;imshow(mat2gray(contour_canny));title('Contour Avec Operateur Canny');
