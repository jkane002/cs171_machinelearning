function init_centroids = kmeanspp(x_input, K)

% select a random flower and declare it as centroid c1
rnum = floor(149.*rand+1);
init_centroids = zeros(K,4);
init_centroids = x_input(rnum,:);


% repeat for all k centroids
for i=1:K
    % for all remaining data pts xj compute distance D(xj,c1)
    dista = lp_norm(x_input,init_centroids,2).^2; 
     % select a random flower w/ probability proportional to D(xj,c1)^2
    %   and set it as c2
    dista = min(dista,[],2);
    x = transpose(1:150);
    
%   y is the index of the randsample with weights
%   distsqrtmat(y) is one of the farthest distances
    y = randsample(x,1,true,dista);
    
%     creates init_centroids based o
    init_centroids(i,:) = [init_centroids ; x_input(y,:) ];
end
  

assignin('base', 'ec_rnum',rnum);
assignin('base', 'ec_dist',dista);
assignin('base', 'ec_x', x);
assignin('base', 'ec_y', y);
assignin('base', 'ec_init', init_centroids);
end