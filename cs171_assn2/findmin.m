function [sortedVals, sortedLabels] = findmin(data, k)
% array with min, array with labels
% iterates through k
    for i = 1:k
%    col vec containing the min val of each row.
    [rows,cols] = min(data,[],2);
        if i == 1
            sortedVals = rows;
            sortedLabels = cols;
        else
%             puts in the min at the correct position
            sortedVals = [sortedVals,rows];
            sortedLabels = [sortedLabels,cols];
        end
        
%         sets data at j to inf
        for j = 1:size(data,1)
            data(j,cols(j,1)) = inf;
        end
    end
 
assignin('base','sortedVals',sortedVals);
assignin('base','sortedLabels',sortedLabels);
end


