function [accuracy, sensitivity, specificity] = confusionfn(y_pred,y_labs)
%   TP  FN      TOTAL (P)
%   FP  TN      TOTAL (N)
% TOTAL TOTAL   BIGTOTAL
%     y_pred
%     y_labs
    confusionmat = zeros(3,3);
    for i=1:size(y_pred,1)
%         TP
        if y_pred(i,1) == 2 && y_labs(i,1) == 2
            confusionmat(1,1) = confusionmat(1,1) + 1;
        end
%         FP
        if y_pred(i,1) == 2 && y_labs(i,1) == 4
            confusionmat(2,1) = confusionmat(2,1) + 1;
        end
%         FN
        if y_pred(i,1) == 4 && y_labs(i,1) == 2
            confusionmat(1,2) = confusionmat(1,2) + 1;
        end
%         TN
        if y_pred(i,1) == 4 && y_labs(i,1) == 4
            confusionmat(2,2) = confusionmat(2,2) + 1;
        end
    end

   
        confusionmat(1,3) = confusionmat(1,2) + confusionmat(1,1);
        confusionmat(2,3) = confusionmat(2,1) + confusionmat(2,2);

        confusionmat(3,1) = confusionmat(1,1) + confusionmat(2,1);
        confusionmat(3,2) = confusionmat(1,2) + confusionmat(2,2);
        % total
        confusionmat(3,3) = confusionmat(1,3)+  confusionmat(2,3);
    
    %ACCURACY (TP+ TN)/ALL
    accuracy = (confusionmat(1,1) + confusionmat(2,2))/confusionmat(3,3);

    
%     SENSITIVITY TP/P
    sensitivity = confusionmat(1,1)/confusionmat(1,3);
%     SPECIFICITY TN/N
    specificity = confusionmat(2,2)/confusionmat(2,3);
    assignin('base', 'confusionmat',confusionmat);
    assignin('base', 'ypredconfused',y_pred);
    assignin('base', 'y_labs',y_labs);
%  2 benign and 4 mal
    %TP : benign actually benign
    %FP : benign actually malignant
    %TN : malignant actually malignant
    %FN : malignant actually benign

    
end