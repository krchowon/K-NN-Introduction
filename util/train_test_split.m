
% Splits data set into training and test sets
%   Inputs:
%   - x outpu
%   - y
%   
%
function [x_train, y_train, x_test, y_test] = train_test_split(x, y, train_pct)

    % 0) Get dimensions of x & y
    %   i) retrieve name of points
    x_col = x.Properties.VariableNames;
    y_col = y.Properties.VariableNames;

    %   ii) retrieve number of rows in both x and y
    num_x = size(y,1);
    num_y = size(x,1);
    
    %       -check that the variables x and y have the same lengths
    if (num_x ~= num_y)
        msgID='test_train_split:mismatchedSize';
        msg = 'explanatory(x) and response(y) have mismatching size.';
        causeException = MException(msgID, msg);
        
        throw(causeException);
    end
    
    % 1) Random Selection of training Set
    %   i) randomize vector of index and sort to choose training set
    train_rank = rand(num_x, 1);
    x(:,{'train_rank'})= array2table(train_rank);
    x = sortrows(x, 'train_rank');
    y(:,{'train_rank'})= array2table(train_rank);
    y = sortrows(y, 'train_rank');
    
    % 2) slice and dice into train and test set
    train_cut = floor(num_x*train_pct);
    
    x_train = x(1:train_cut, x_col);
    x_test = x(train_cut+1: num_x, x_col);
    y_train = y(1:train_cut, y_col);
    y_test = y(train_cut+ 1: num_y, y_col);
end 