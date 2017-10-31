function im = traitement_bordures(im_originale)
[m_orig,n_orig,nb_gs]= size(im_originale);
% Traitement anti-probléme des bordures:
im=zeros(m_orig+4,n_orig+4,nb_gs);
 for gs=1:nb_gs
   im(:,:,gs)= [im_originale(1,1,gs) im_originale(1,1,gs) im_originale(1,1:n_orig,gs) im_originale(1,n_orig,gs) im_originale(1,n_orig,gs);...
                im_originale(1,1,gs) im_originale(1,1,gs) im_originale(1,1:n_orig,gs) im_originale(1,n_orig,gs) im_originale(1,n_orig,gs);...
                im_originale(1:m_orig,1,gs) im_originale(1:m_orig,1,gs) im_originale(1:m_orig,1:n_orig,gs) im_originale(1:m_orig,n_orig,gs) im_originale(1:m_orig,n_orig,gs);...
                im_originale(m_orig,1,gs) im_originale(1,n_orig,gs) im_originale(m_orig,1:n_orig,gs) im_originale(m_orig,n_orig,gs) im_originale(m_orig,n_orig,gs);...
                im_originale(m_orig,1,gs) im_originale(1,n_orig,gs) im_originale(m_orig,1:n_orig,gs) im_originale(m_orig,n_orig,gs) im_originale(m_orig,n_orig,gs)];
 end
 

end