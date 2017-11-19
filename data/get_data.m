
function fruits = get_data(raw_fruits_file)
    % 1) Configure data
    % raw_fruits_file = 'C:\DEV Space\mat_knn\data\fruit_data_with_colors.txt';

    % 2) Specify cleaning and formating
    formatSpec = '%f%C%C%f%f%f%f';
    fruits = readtable(raw_fruits_file, 'Delimiter', '\t', 'Format', formatSpec);

    % 3) Clean Data here:

end 