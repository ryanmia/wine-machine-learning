function predicted=apply_logistic_regression_model(thetas,data)
    num_thetas=size(data,2);
    data_len=size(data,1);
    predicted=zeros(data_len,1);
    for d=1:data_len
        eVal=1;
        for i=1:num_thetas
            eVal=eVal*exp(-thetas(i)*data(d,i));
        end
        yhat=1/(1+eVal);
        if yhat<.5
            predicted(d)=0;
        else
            predicted=1;
        end
    end
end