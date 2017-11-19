function accuracy = accuracy_knn(knn_model, x_test, y_test)
    % 0) Predict label
    y_hat = predict(knn_model, x_test);       
    
    len_y_hat = size(y_hat, 1);
    len_y_test = size(y_test, 1);
    
    %   - check outputs are the same dimensions
    if (len_y_hat ~= len_y_test)
        msgID='accuracy_knn:mismatchedSize';
        msg = 'predicted value(y_hat) and response(y) have mismatching size.';
        causeException = MException(msgID, msg);
        
        throw(causeException);
    end    
    
    % 1) calculate accuracy
    correct = 0;
    for i=1:len_y_hat
        if y_hat(i) == y_test(i)
            correct = correct + 1;
        end 
    end 
    
    accuracy = correct / len_y_hat;
end 