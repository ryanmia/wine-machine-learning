function deriv=derivative_logreg(thet_ind,thetas,data,data_labels)
    deriv=0;
    data_len=size(data,1);
    num_thetas=size(data,2);
    for d=1:data_len
        eVal=1;
        for i=1:num_thetas
            eVal=eVal*exp(-thetas(i)*data(d,i));
        end
        yhat=1/(1+eVal);
        deriv=deriv+(1/data_len)*(yhat-data_labels(d))*data(d,thet_ind);
    end
end