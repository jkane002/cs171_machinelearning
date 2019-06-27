function [meanmat, stdmat] = crossvalidation(data)
%    seeds
%     rng(0);
%     shuffles data
    data_shuffled = data(randperm(size(data,1)),:);
%     gives me the size of each interval
    datsize = ceil(size(data,1)/10);

    k = 10;
    p = 2;
    
    meanmat = zeros(k,6);
    stdmat  = zeros(k,6);
    
   for x=1:k % iterates through k
       zindex = 1;
       index = 1;
    for y=1:p % iterates through p
        u = 1;
        v = datsize;
        for z=1:10
            tempdata = data_shuffled;
            tempdata(u:v,:) = []; %deletes the interval from tempdata
            x_test = data_shuffled(u:v,2:10);
            y_labs = data_shuffled(u:v, 11);
            x_train = tempdata(:,2:10);
            y_train = tempdata(:,11);

            y_pred = knn_classifier(x_test, x_train, y_train, x, z);
            
%            % each accuracy, sensitivity, and specificity matrix has
             % first 10 rows (10 folds) for p = 1
             % last 10 rows (10 folds)for p = 2
             % 10 columns for k
   [accuracy(zindex,x), sensitivity(zindex,x), specificity(zindex,x)] = confusionfn(y_pred,y_labs);
            zindex = zindex + 1;
           
            u = v + 1; %sets the beginning index of the next interval
            if datsize + u >= 700
                v = 699; %sets the ending index of the next interval
            else
                v = datsize + u -1;
            end
        end
        
        if y == 1
             first = 1;
            second = 10;
        elseif y == 2
            first = 11;
            second = 20;
        end 
        
        meanmat(x,index) = mean(accuracy(first:second,x),1);
        meanmat(x,index+1) = mean(sensitivity(first:second,x),1);
        meanmat(x,index + 2) = mean(specificity(first:second,x),1);
        
        stdmat(x,index) = std(accuracy(first:second,x),1);
        stdmat(x,index+1) = std(sensitivity(first:second,x),1);
        stdmat(x,index + 2) = std(specificity(first:second,x),1);
        
        index = index + 3;
%         rows = k 
%         cols = p = 1 accuracy, sensitivity, specificity, 
%         cols = p = 2 accuracy, sensitivity, specificity,
    end
   end
   
   
         assignin('base', 'data_shuffled',data_shuffled);

     assignin('base', 'datsize',datsize);
    assignin('base', 'accuracy',accuracy);
    assignin('base', 'sensitivity',sensitivity);
    assignin('base', 'specificity',specificity);
    
   
end