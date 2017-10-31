%% autheur: Belmamoun Adnane
%% Master I.T 2010-2012 LRIT-GSCM.
%% Encadré par: Pr A.Hammouch / Pr I.Guelzim 
%% implémentation de la detection de contour par :
%% New approche for edge detection -----> perfect alignment

function contour_finale = ADA_TRE_ENT_OPERATOR(im,x,y)

[m,n,nb_gs]= size(im);

%Demi-Taille du  voisinage 2 ou 3 ou 5
W=3;
% quart de taille du  voisinage utile pour le definir la taille de fenetre
% glissante:
l=floor(W/2);
if l==1    
    l=l-1;
end
ll=l+1;
% taille du  voisinage
L=floor(W^2);
% paramétre utile pour le seuillage de la valeur minimum d'entropie
 precision = 2;
 % paramétres du pré-traitemnt: x==> taille filtre moyenneur.
 %                              y==> nbre de classe pour quantification 
% x=5;   y=6;
  
   if(nb_gs>1)  
    %% pré-traitement de l'image originale:
    im = pretraitement_image(im,x,y);
   end


nb_experience =1;
% je demarre le chrono
tic
for compteur=1:nb_experience
% j'initialise un vecteur de voisinage de taille L=2*2 ou 3*3 ou 5*5 pour chaque pixel
% voisinage=zeros(1,L);
% Matrice des probabiltés de chaque pixel d'un voisinage de l'image, 
% Matrice 4 dimensions:
prob_i =zeros(m-W+1,n-W+1,L,nb_gs);
H_i =zeros(m-W+1,n-W+1,L,nb_gs);
% H =zeros(m-W+1,n-W+1,nb_gs);
probcentralpx_i =zeros(m-W+1,n-W+1,L,nb_gs);
Hcentralpx_i =zeros(m-W+1,n-W+1,L,nb_gs);
seuil_local_low=zeros(m,n,nb_gs);
prob_i_back =zeros(m-W+1,n-W+1,L,nb_gs);
H_i_back =zeros(m-W+1,n-W+1,L,nb_gs);
probcentralpx_i_back =zeros(m-W+1,n-W+1,L,nb_gs);
Hcentralpx_i_back =zeros(m-W+1,n-W+1,L,nb_gs);
seuil_local_low_back=zeros(m,n,nb_gs);
% seuil_local_high_back=zeros(m,n,nb_gs);
% seuil_test=zeros(m,n,nb_gs);

% ici je defini mon contour
contour = 255*ones(m,n);%,gs contour avec entropie couleur H_couleur

%contour couleur par entropie pour chaque bande
contour_couleur = 255*ones(m,n,nb_gs);% pixel_contour =255;
contour_couleur_back = 255*ones(m,n,nb_gs);% pixel_contour =255;
contour_couleur_forg = 255*ones(m,n,nb_gs);% pixel_contour =255;

for i= W-l:m-W+ll
    % parcour des colonnes
   for j=W-l:n-W+ll
        % parcour des 3 bandes couleur(nb_gs== nombre de grascale level)
      for gs = 1:nb_gs
        voisinage =[im(i,j,gs),im(i-1,j-1,gs), im(i-1,j,gs), im(i-1,j+1,gs),...
                   im(i,j+1,gs), im(i+1,j+1,gs), im(i+1,j,gs), im(i+1,j-1,gs), im(i,j-1,gs)];
   %% Maintenant je commence l'operation de calcul de l'entropie de chaque voisinage:         
       Mean_Voisinage = mean(voisinage);
        % je parcour les  (L-1= 2:9) L pixels de chaque
        % voisinage centré au pixel i,j:
        centre_vois=voisinage(1);
     for k= 2:L
            % ici la somme des brightness de chaque pixel du voisinage
            vois= voisinage(k);
             % attention ici la somme est effectuée sur tout le voisinage
             % 3x3:(9pixels)==> prob_i est bien une matrice de
             % probabilités:
                 somme_vois =sum(voisinage(:));
                 somme_vois_back =voisinage(1)+voisinage(3)+voisinage(5)+voisinage(7)+voisinage(9);%sum(voisinage(:)); 
            % ici je calcul les probabiltés locale pour chaque pixel du
            % voisinage:
            if(somme_vois~=0)
                prob_i(i,j,k,gs) = double(vois) / somme_vois; 
                probcentralpx_i(i,j,k,gs) = double(centre_vois) / somme_vois; 
            else
                %si somme_vois ==0 alors :
                prob_i(i,j,k,gs) = double(0);
                probcentralpx_i(i,j,k,gs) = double(0);
            end
            
            if(k==3||k==5||k==7||k==9)
              if(somme_vois_back~=0)
                prob_i_back(i,j,k,gs) = double(vois) / somme_vois; 
                probcentralpx_i_back(i,j,k,gs) = double(centre_vois) / somme_vois; 
              else
                %si somme_vois ==0 alors :
                prob_i_back(i,j,k-1,gs) = double(0);
                probcentralpx_i_back(i,j,k-1,gs) = double(0);
              end
            end
            
            %% ici je calcul l'entropie
            if(probcentralpx_i(i,j,k,gs)~=0)
               Hcentralpx_i(i,j,k,gs) = probcentralpx_i(i,j,k,gs)*log2(probcentralpx_i(i,j,k,gs));
            else
               Hcentralpx_i(i,j,k,gs) = double(0);
            end
          %% ******************************************************  
            if(prob_i(i,j,k,gs)~=0)
               H_i(i,j,k,gs) = prob_i(i,j,k,gs)*log10(prob_i(i,j,k,gs));
            else
               H_i(i,j,k,gs) = double(0);
            end
        %% ********************************************************
        
        %% ici je calcul l'entropie background
            if(probcentralpx_i_back(i,j,k,gs)~=0)
              Hcentralpx_i_back(i,j,k,gs) = probcentralpx_i_back(i,j,k,gs)*log10(probcentralpx_i_back(i,j,k,gs));
            else
              Hcentralpx_i_back(i,j,k,gs) = double(0);
            end
          %% ******************************************************  
            if(prob_i_back(i,j,k,gs)~=0)
               H_i_back(i,j,k,gs) = prob_i_back(i,j,k,gs)*log10(prob_i_back(i,j,k,gs));
            else
               H_i_back(i,j,k,gs) = double(0);
            end
            
%% ************************************************************************
%% ************************************************************************

%% ************************************************************************
%%        Nouveau Seuillage Adaptatif en double connexité 3x3 et 2x2
%% ************************************************************************
      if(W==3)
          %% D'abord un Tresholding au niveau de la connéxité 3x3
          if(k>=2 && k<=9)
             precis=2;
             seuil_local_low(i,j,gs) = double(Hcentralpx_i(i,j,k,gs)- double(Hcentralpx_i(i,j,k,gs))/(precis));
               if((double(H_i(i,j,k,gs)) >seuil_local_low(i,j,gs))) 
                          %% ICI JE CHERCHE MON CONTOUR pour chaque fenetre:
                               contour_couleur_forg(i,j,gs)=0;
                               if(nb_gs>1)
                                 contour_couleur(i,j,gs)=0;
                                 contour_couleur_back(i,j,gs)=0;
                               end
                          contour(i,j)=0;
               end
               
          end
          %% puis je fais ma recherche supplementaire par tresholding sur connexité 2x2 
          if((k==2 || k==3 || k==4 || k==5))%contour_couleur(i,j,gs)~=0 &&
                  seuil_local_low_back(i,j,gs) = double(Hcentralpx_i_back(i,j,k,gs));%+double(Hcentralpx_i_back(i,j,k,gs)));
                      if((double(H_i_back(i,j,k,gs)) ~= seuil_local_low_back(i,j,gs)))
                              contour_couleur_back(i,j,gs)=0;
                              contour_couleur(i,j,gs)=0;
                              contour(i,j)=0;
                      end
          end
                 
                if(nb_gs>1)
                  %% Enfin je fais un raffinement des pixels contours déja
                  %% detectés localement dans la fenetre 3x3 e cours:    
                  %% { ce sont les pixels (i-1,j-1)&(i-1,j)&(i-1,j+1)&(i,j-1) }
                  if(contour_couleur(i,j,gs)==0)
                      if(contour_couleur(i-1,j,gs)==0 && contour_couleur(i,j-1,gs)==0)
                         if(contour_couleur(i-1,j-1,gs)==0)
                             %% Enfin J'élimine le superflux(pixels contours doubles)
                               contour_couleur(i-1,j-1,gs)=255;
                         end
                      end             
                  end
                end
     end
    end % fin boucle sur les elements de chaque voisinage
        
     end % FIN BOUCLE SUR les 3 bandes

  end
 
end
   % arrêt du chronometre:
    toc
  contour_finale = inversion_couleur(contour_couleur);
end % boucle sur nombre d'experience pour image de synthese uniquement

end