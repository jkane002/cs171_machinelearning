function y_pred = knn_classifier(x_test, x_train, y_train, k, p)
% creates an array of size 140x599
lp_norm = zeros(size(x_test,1),size(x_train,1));
y_pred = zeros(size(x_test,1),1);
% Iterates through row for x_test
    for i = 1:size(x_test,1)
    %     Iterates through row for x_train (same size as x_test)
        for l = 1:size(x_train,1)
    %         Iterates col to find distances
            for j = 1:size(x_train,2)
                diff = abs( x_test(i,j) - x_train(l,j) );
                lp_norm(i,l) = lp_norm(i,l) + diff^p;
            end
            lp_norm(i,l) = lp_norm(i,l)^(1/p);
        end
    end
   
    
    % lpSorted is sorted lp_norm
    [lpSorted, label_mat] = findmin(lp_norm, k);
    
    
    % iterates through lpSorted's col
    for i = 1:size(lpSorted,1)
        %sets counter to a 2x1 array with 0
        cnt = zeros(2,1);
        % iterates through k 
        for j=1:size(lpSorted,2) %change
            ind= label_mat(i,j);
            if y_train(ind,1)== 2 %if benign
                cnt(1,1) = cnt(1,1) + 1;
            else % if malignant
                cnt(2,1) = cnt(2,1) + 1;
            end
        end
        %counter
        if cnt(1,1) >= cnt(2,1)
            y_pred(i,1) = 2;
        else
            y_pred(i,1) = 4;
        end
    end
    assignin('base', 'knn_y_train', y_train);
    assignin('base', 'label_mat'  , label_mat);
    assignin('base', 'lp_norm'    , lp_norm);
    assignin('base', 'lpSorted'   , lpSorted);
    assignin('base', 'lp_norm'    , lp_norm);
    assignin('base', 'y_pred'     , y_pred);
end
 
 
% 1-558     80%     x_train
% 559-669   20%     x_test