function [cluster_assns, cluster_cen] = k_means_cs171(x_input, K, init_centroids)

p = 2; % Euclidean distance
cluster_cen = init_centroids;

%2. Repeat while cluster assignments don't change:
for z=1:1000
    % data point x 1 w/ the cluster # crrspnding to data pt
    cluster_assns = lp_norm(x_input,cluster_cen,p);
  
%     find index of min in each row in cluster_assns
    [minmat, indices] = min(cluster_assns,[],2);

%  a) Assign each point to the nearest centroid using Euclidean distance
    cluster_cen = zeros(K, size(x_input,2)+1);
    for i=1:size(x_input, 1)
         cluster_cen(indices(i),1:4) = cluster_cen(indices(i),1:4) + x_input(i, :);
         cluster_cen(indices(i),5) = cluster_cen(indices(i),5) + 1;
    end
    
% b) Given new assignments, compute new cluster cen. as mean of all pts in cluster
    newclusters = zeros(K, size(x_input,2)+1);
%     iterate through the rows of cluster_cen
    for i=1:size(cluster_cen,1)
        for j=1:size(cluster_cen,2)
            newclusters(i,j) = cluster_cen(i,j) / cluster_cen(i,5);
        end
    end
    
    newclusters(:,5) = [];
    cluster_cen = newclusters;
end
cluster_assns = indices;

assignin('base', 'minmat', minmat);
assignin('base', 'indices', indices);
assignin('base', 'newclusters', newclusters);
end
