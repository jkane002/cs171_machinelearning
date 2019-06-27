function s  = sse(cluster_assns, cluster_cen, x_input)

ssemat = zeros(size(cluster_assns,1),1);

% Iterates through row of cluster_assns
    for i = 1:size(cluster_assns,1)
        cen = cluster_cen( cluster_assns(i,1), : );
    %         Iterates col of cen to find distances
            for j = 1:size(cen,2)
                diff = abs( x_input(i,j) - cen(1,j) );
                ssemat(i,1) = ssemat(i,1) + diff^2;
            end
            ssemat(i,1) = ssemat(i,1)^(1/2);
    end
    
%     sum up all of ssemat
s = sum(ssemat,1);

end