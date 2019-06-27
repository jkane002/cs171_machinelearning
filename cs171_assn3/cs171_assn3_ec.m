clear; clc;
a = load('iris.mat');
data = a.iris(:,:);

x_input = a.iris(1:150,1:4);
K = 10;
max_iter = 100; % changes from 2, 10, 100
ssemat = zeros(max_iter,K);
% make a for loop iterating through k
for jk=1:K
    % iterates through max_iter
    for max=1:max_iter 
       %1. Initialize cluster centroids:
        init_centroids = kmeanspp(x_input, jk);
        [cluster_assns, cluster_cen] = k_means_cs171(x_input, jk, init_centroids); 
        ssemat(max,jk) = sse(cluster_assns, cluster_cen, x_input);
    end
    % mean
    
    
    meanstd(jk,1) = mean(ssemat(:,jk),1);
    meanstd(jk,2) = std(ssemat(:,jk),1);
%     each row is k, 1 col is mean , 2nd col is std
end


x = linspace(1,10,10);
y = meanstd(:,1);
err = meanstd(:,2);
errorbar(x,y, err);
title('k10-maxiter-100');
xlabel('K values');
ylabel('sum of squares of errors of all data pts');
% saveas(gcf, 'k10_maxiter_100', 'png');

