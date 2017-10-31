function contour_finale = inversion_couleur(contour_couleur)
[m,n,nb_gs]= size(contour_couleur);
contour_finale=zeros(m,n,nb_gs); %version inversée du contour pixel_contour=0
for iii = 1:m
    for jjj = 1:n
        for kkk = 1:nb_gs
            if(contour_couleur(iii,jjj,kkk) ~=0)%== 255)
                contour_finale(iii,jjj,kkk) =0;
            end
            if(contour_couleur(iii,jjj,kkk) == 0)
                contour_finale(iii,jjj,kkk) =1;
            end
        end
    end
end

end