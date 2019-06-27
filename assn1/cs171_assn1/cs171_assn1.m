clc;clear;
a = load('wine.mat'); % code changes according to iris/ wine dataset
bin = 100; % changes according to bin sizes
first = a.wine(60:130,2); %CHANGE according to iris / wine dataset
box_plot = first;
min_first = min(first);
max_first = max(first);
range = (max_first - min_first)/bin; % finds the range
Y = zeros(1,bin);
r1 = min_first;
r2 = min_first + range; % this becomes the incremental
X = cell(1,bin);
for i=1:bin
    X{i} = sprintf('%.4f-<%.4f', r1, r2);
    if i==bin % basically adds leverage to accomodate the extra bin
        Y(i) = size(first(first>=r1 & first<r2 + 0.001),1);
    else
        Y(i) = size(first(first>=r1 & first<r2),1);
    end
    r1 = r2;
    r2 = r2 + range;
end
X = categorical(X);
bar(X,Y,1);


h = heatmap(heatmat);

% Changes according to wine/iris dataset
boxplot(box_plot);
title(['Wine class3: Bin:' num2str(bin)]); 
xlabel('alcohol');
ylabel('alcohol');

saveas(gcf,'boxplot_class2_alcohol','png');

% % % % % % % % % % % % % % % % % % % 
%   WINE HEATMAP
% % % % % % % % % % % % % % % % % % % 

sizeWineCol = size(a.wine,1);
heatmat(3,3) = 0;
for i=2:4 % iterates through attributes
    for j=2:4 %  iterates through attributes
        add = 0;
        for k=1:sizeWineCol % iterates through size
            x_i = a.wine(k,i);
            y_j = a.wine(k,j);
            xmean = mean(a.wine(:,i)); % sets mean
            ymean = mean(a.wine(:,j));% sets mean
            xstd = std(a.wine(:,i)); % sets std dev.
            ystd = std(a.wine(:,j));% sets std dev.
            add = add + ((x_i - xmean)*(y_j - ymean));
        end
            cov = add/sizeWineCol; % covariance form.
            heatmat(i-1,j-1) = cov/(xstd * ystd);
    end
end
H = heatmap(heatmat);
H.XData = ["Alcohol" "Malic Acid" "Ash"];
H.YData = ["Alcohol" "Malic Acid" "Ash"];
H.title("Wine heatmap");


% % % % % % % % % % % % % % % % % % % % 
%   IRIS HEATMAP
% % % % % % % % % % % % % % % % % % % % 
b = load('iris.mat'); 
sizeIrisCol = size(b.iris,1);% sets the size
heatmat1(4,4) = 0; % initalizes matrix to zero
for i=1:4 % iterates through the attributes
    for j=1:4 %  iterates through the attributes
        add = 0;
        for k=1:sizeIrisCol % iterates through the size
            x_i = b.iris(k,i);
            y_j = b.iris(k,j);
            xmean = mean(b.iris(:,i)); % finds the mean
            ymean = mean(b.iris(:,j)); % finds the mean
            xstd = std(b.iris(:,i)); % finds std deviation
            ystd = std(b.iris(:,j)); % finds std deviation
            add = add + ((x_i - xmean)*(y_j - ymean));
        end
            cov = add/sizeIrisCol; % covariance formula
            heatmat1(i,j) = cov/(xstd * ystd); 
    end
end
I = heatmap(heatmat1);
I.XData = ["Sepal Length" "Sepal Width" "Petal Length" "Petal Width"];
I.YData = ["Sepal Length" "Sepal Width" "Petal Length" "Petal Width"];
I.title("Iris heatmap");


% % % % % % % % 
scatter plot for iris
for i=1:4 % iterates throught the attributes
    for j=1:4 % iterates through the attributes
        graph1= scatter(b.iris(1:50,i), b.iris(1:50,j), 'filled', 'red'); 
        hold on; %keeps the graph
        graph2= scatter(b.iris(51:100,i), b.iris(51:100,j), 'filled', 'green');
        hold on; %keeps the graph
        graph3 = scatter(b.iris(101:150,i), b.iris(101:150,j), 'filled', 'blue');
        hold on; %keeps the graph
        
        % created an array for a list of strings for the attributes
        attrib = ["sepal length" "sepal width" "petal length" "petal width"];
        formatSpec = "scatterplot_%s-vs_%s.png";
        filename = sprintf(formatSpec,attrib(i),attrib(j));
        saveas(gcf,filename);
        delete(graph1); % must delete graphs or else all 16 graphs will overlap
        delete(graph2);
        delete(graph3);
    end
end


% % % % % % % % % 
% Feature Distribution for wine
p = 1; % changes p to 1 or 2 for lp 1 or lp 2
n = size(a.wine,1); % n is the size depending on the dataset
sumlp = 0;
lpMatrix(n,n) = 0; 
for i=1:n % iterates through the rows
    for j=1:n %iterates through the cols
        sumlp = 0;
        for k=2:4 % goes through the attributes
            x_norm = a.wine(i,k);
            y_norm = a.wine(j,k);
            sumlp  = sumlp + (abs(x_norm-y_norm))^p; 
        end
        lpnorm = (sumlp)^(1/p); %dist formula
        lpMatrix(i,j) = lpnorm; %puts lpnorm into each index of the matrix
    end
end

lpH = heatmap(lpMatrix);
filename = ['wine_dist_dataset_heatmap_p' num2str(p)];
lpH.title(filename);
saveas(gcf,filename,'png');



% % % % % % % % % 
% Feature Distribution for iris
p = 1; % changes p to 1 or 2 for lp 1 or lp 2
n = size(b.iris,1); % n is the size depending on the dataset
sumlp = 0;
lpMatrix(n,n) = 0; 
for i=1:n % iterates through the rows
    for j=1:n %iterates through the cols
        sumlp = 0;
        for k=1:4 % goes through the attributes
            x_norm = b.iris(i,k);
            y_norm = b.iris(j,k);
            sumlp  = sumlp + (abs(x_norm-y_norm))^p; 
        end
        lpnorm = (sumlp)^(1/p); %dist formula
        lpMatrix(i,j) = lpnorm; %puts lpnorm into each index of the matrix
    end
end

lpH = heatmap(lpMatrix);
filename = ['Iris_dist_dataset_heatmap_p' num2str(p)];
lpH.title(filename);
saveas(gcf,filename,'png');

% % % % % % % 
%  NEAREST POINT: IRIS
c = load('iris.mat');
rowSize = size(c.iris,2);
colSize = size(c.iris,1);
neartable(rowSize, 1) = 0; %creates a table to hold the min distance
distTable(rowSize, 1) = 0; %table w/ the min dist among the rows
for i=1:colSize
    mini = min(c.iris(i,:));
    dist = 0;
    counter = 0;
    for j=1:rowSize
       temp = c.iris(i,j) - mini;
           if (temp > dist) && (temp  ~= 0.0000) % finds the minimum distance
               dist = temp;
           end
       neartable(i,1) = dist;
           if neartable(i,1) == c.iris(i,j) % checks dist b/w each pt then
                counter = counter + 1;      %increments counter
           end
           distTable(i,1) = counter/rowSize; % puts how many min distances has occurred in the row
           % shown as a percentage
    end
end

% % % % % % % 
 NEAREST POINT: WINE
c = load('wine.mat');
rowSize = size(c.wine,2);
colSize = size(c.wine,1);
neartable(rowSize, 1) = 0; %creates a table to hold the min distance
distTable(rowSize, 1) = 0; %table w/ the min dist among the rows
for i=1:colSize
    mini = min(c.wine(i,:));
    dist = 0;
    counter = 0;
    for j=2:rowSize
       temp = c.wine(i,j) - mini;
           if (temp > dist) && (temp  ~= 0.0000) % finds the minimum distance
               dist = temp;
           end
       neartable(i,1) = dist;
           if neartable(i,1) == c.wine(i,j) % checks dist b/w each pt then
                counter = counter + 1;      %increments counter
           end
           distTable(i,1) = counter/rowSize; % puts how many min distances has occurred in the row
%            shown as a percentage
    end
end


