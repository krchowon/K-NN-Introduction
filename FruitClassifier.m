% Problem Definition
% In this script, I will demonstrate a simple Classification Problem of 
% fruits across height, width, mass, and color using the
% K-NearestNeighbours algorithm. In this script I hope to guide you through
% how I enjoy structuring this problem.

addpath('./data');
addpath('./util');

% 0) Retrieve and Clean data
% Fruits Data contains mass, height, and width of a selection of oranges, 
% lemons and apples.  The heights were measured along the core of the  
% fruit. The widths were the widest width perpendicular to the height.
raw_fruits_file = './data/fruit_data_with_colors.txt';
fruits = get_data(raw_fruits_file);

summary(fruits)

% 1) Split training and test data
train_pct = 0.8;
features = {'height', 'width', 'mass', 'color_score'};
response = {'fruit_label'};

x = fruits(:,features);
y = fruits(:,response);

[x_train, y_train, x_test, y_test] = train_test_split(x, y, train_pct);
%% 

% 2) Review/Explore Data sets. 
% In any data science exercise, inspecting the data first is critical in
% finding strong relationships in data and/or finding anomalies in the data
% set.

%   i) Visualize data
[~, ax] = plotmatrix(table2array(x_train));
for col = 1:size(features,2)
    ax(col,1).YLabel.String= features(col);
    ax(size(features,2),col).XLabel.String= features(col);
end    
%%
%   ii)Closer look on width and height:
fruit_map = fruits(:,{'fruit_label', 'fruit_name'});
fruit_map = unique(fruit_map);

fruit_cmap = linspace(1,8, size(fruit_map,1));
cmap = zeros(size(y_train,1),1);

hold on;
for i=1:size(fruit_map)
    fl = table2array(fruit_map(i,{'fruit_label'}));
    fn = table2array(fruit_map(i,{'fruit_name'}));
    fruit_filter = table2array(y_train) == fl;
    
    x_train_height = table2array(x_train(fruit_filter, {'height'}));
    x_train_width = table2array(x_train(fruit_filter, {'width'}));
    cmap = zeros(length(x_train_height),1);
    cmap(:) = fruit_cmap(fl);
    scatter(x_train_height, x_train_width, 25, cmap, 'filled');    
end
title('Fruit partition by HxW');
xlabel('Height');
ylabel('Width');

%{
x_train_height = table2array(x_train(:,{'height'}));
x_train_width = table2array(x_train(:, {'width'}));
s = scatter( x_train_width, x_train_height, 15, cmap, 'filled');

title('Fruit partition by HxW');
xlabel('Width');
ylabel('Height');

legend('apple', 'orange', 'lemons', 'mandarin');
%}
%%
% 3) Apply KNN algorithm
%   i) apply algo
fruit_model = fitcknn(table2array(x_train),table2array(y_train), 'NumNeighbors', 5);
fm5_accuracy = accuracy_knn(fruit_model, table2array(x_test), table2array(y_test));

disp('Accuracy of 5-NearestNeighbor algorithm on test set scored: ');
disp(fm5_accuracy);

%   ii) Example of predicting points given the features:
x_new = [7.6, 7.2, 168, 0.75];
y_new_hat = predict(fruit_model, x_new);
y_fruit = fruit_map(table2array(fruit_map(:,{'fruit_label'})) == y_new_hat, {'fruit_name'});

disp('KNN Model would predict a new fruit (height, weight, mass, color_score) of : ');
disp(x_new);
disp('as an:');
disp(table2array(y_fruit));
%%
% 4) Test Sensitivity of KNN to parameter K
n_neighbour = zeros(size(x_train,1),1);
n_accuracy = zeros(size(x_train,1),1);
for n=1:size(x_train,1)
    fruit_model = fitcknn(table2array(x_train),table2array(y_train), 'NumNeighbors', n);
    accuracy = accuracy_knn(fruit_model, table2array(x_test), table2array(y_test));    
    n_neighbour(n)= n;
    n_accuracy(n) = accuracy;
end

s = scatter(n_neighbour, n_accuracy, 'filled');
title('KNN Sensitivity');
ylabel('Accuracy');
xlabel('K-Nearest Neighbours')
% K Nearest Neighbours appears very sensitive to choice of K. Shape of
% accuracy across choice of N has large variance in accuracy. However, the
% algorithm seems optimal around 5-7 nearest neighbours.