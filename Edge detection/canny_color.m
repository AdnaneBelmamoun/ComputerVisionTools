function [canny,tresh] = canny_color(im)
[m,n,nb_gs]= size(im);
canny=zeros(size(im));
tresh=zeros(nb_gs,2);
 for gs=1:nb_gs
    [canny(:,:,gs),tresh(gs,:)]=edge(im(:,:,gs),'canny',[]);
 end
 
end