% % ici l'algorithme  de l'article de Bilateral Mesh Denoising
% 
% % debruitage d'un point de coordonnées (sommet v, normale n)
% 
% 
% clear options;
% name = 'elephant-50kv';
% options.name = name; % useful for displaying
% [vertex0,face] = read_mesh(name);
% 
% Compute the normal to the mesh.
% 
% normals = compute_normal(vertex0,face);
% 
% Number of vertex and number of faces.
% 
% n = size(vertex0,2);
% m = size(face,2);
% 
% Tangencial displacements do not impact the geometry of the mesh that much.
% 
% We create a noisy mesh by displacement of the vertices along the normal direction (those are the most distructive displacements).
% 
% % amount of noise
% rho = randn(1,n)*.015;
% % displacement
% vertex = vertex0 + repmat(rho,[3,1]).*normals;
% 
% Display the meshes. To have a nice display, with lighting, use plot_mesh(vertex0,face, options).
% 
% options.lighting = 1;
% clf;
% subplot(1,2,1);
% plot_mesh(vertex0,face,options); axis('tight');
% subplot(1,2,2);
% plot_mesh(vertex,face,options); axis('tight');
