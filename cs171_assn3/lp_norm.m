function lpnorm = lp_norm(data, cen, p)
lpnorm = zeros(size(data,1),size(cen,1));
% Iterates through row of data
    for i = 1:size(data,1)
    %     Iterates through row of cen
        for l = 1:size(cen,1)
    %         Iterates col to find distances
            for j = 1:size(cen,2)
                diff = abs( data(i,j) - cen(l,j) );
                lpnorm(i,l) = lpnorm(i,l) + diff^p;
            end
            lpnorm(i,l) = lpnorm(i,l)^(1/p);
        end
    end
end
    
   