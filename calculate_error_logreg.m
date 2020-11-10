function err=calculate_error_logreg(thetas,data,data_labels)
    num_thetas=size(data,2);
    data_len=size(data,1);
    err=0;
    for d=1:data_len
        eVal=1;
        for i=1:num_thetas
            eVal=eVal*exp(-thetas(i)*data(d,i));
        end
        yhat=1/(1+eVal);
        err=err+data_labels(d)*log(yhat)+(1-data_labels(1))*log(1-yhat);
    end
    err=err*-1/num_thetas;
end