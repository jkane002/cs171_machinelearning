% FOR LAB REPORT
% DOCUMENT HOW I FILLED IN MISSING DATA

clc;clear;
a = load('breastcancerwisconsin.mat');
% creates a data matrix w/o serial #'s and classes
data = a.breastcancerwisconsin(1:699,1:11); 
 
% finds the avg which ignores NaN and then rounds up
avg = mean(data, 'omitnan');
avg = round(avg);

count = 0; %test count that counts # of nans

for i=1:size(data,1) %iterates through rows
    for j=1:size(data,2) %iterates through cols
        %if nan at i,j
            %replace i,g with the avg at that specific col
        if isnan(data(i,j))
            data(i,j) = avg(1,j);
        end
    end
end


x_train = data(1:559, 2:10); %top 80%
x_test  = data(560:699, 2:10); %bottom 20%
y_train = data(1:559,11); % last col containing 2's & 4's
k = 1;
p = 2;



% % % % % % % % % % CHANGE
y_pred = knn_classifier(x_test, x_train, y_train, k, p);
% y_pred = 1;
% % % % % % % % % % % % % % % 

% CALLS CROSSVALIDATION


%xaxis:  k
%yaxis: accuracy, spec, sens
%         rows = k 
%         cols = p = 1 accuracy, sensitivity, specificity, 
%         cols = p = 2 accuracy, sensitivity, specificity,

names = ["Accuracy", "Sensitivity", "Specificity"];
[meanmat, stdmat] = crossvalidation(data);
for i=1:3
    xaxis = 1:10;
    aerr = errorbar(xaxis,meanmat(:,i), stdmat(:,i));
    hold on;
    berr = errorbar(xaxis,meanmat(:,3+i), stdmat(:,3+i));
    legend('p = 1', 'p = 2');
    title(names(1,i));
    xlabel("K values");
    ylabel("Performance");
    fs = "%s.png";
    filename = sprintf(fs, names(1,i));
    saveas(gcf, filename);

    delete(aerr);
    delete(berr);
end
% errorbar(xaxis,meanmat(:,2), stdmat(:,2));
% errorbar(xaxis,meanmat(:,5), stdmat(:,5));
% 
% errorbar(xaxis,meanmat(:,3), stdmat(:,3));
% errorbar(xaxis,meanmat(:,6), stdmat(:,6));
