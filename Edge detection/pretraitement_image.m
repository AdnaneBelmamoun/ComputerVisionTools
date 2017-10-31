function im = pretraitement_image(im,x,y)
      [m,n,nb_gs]= size(im);
        %% pré-traitement1 de l'image originale par filtre moyenneur:
        
        for gs=1:nb_gs
           im(:,:,gs) = filter2(fspecial('average',x),im(:,:,gs));%medfilt2(im(:,:,gs),[4 4]);
        end
           %% pré-traitement2 la phase de quantification de l'image avant traitement:
        nb_classe=y;
        for s=1:nb_gs
        pas = double(max(max(im(:,:,s)))-min(min(im(:,:,s))))/nb_classe;
          for i =1:m
              for j = 1:n
                 if(im(i,j,s)<pas)
                     im(i,j,s)=1;
                 end
                 for k = 2:nb_classe-1
                   if(im(i,j,s)<k*pas && im(i,j,s)>=(k-1)*pas )
                     im(i,j,s)=2*k;
                   end
                 end
                 if(im(i,j,s)>(nb_classe-1)*pas)
                    im(i,j,s)=nb_classe; 
                 end
              end
          end
        end
     
end