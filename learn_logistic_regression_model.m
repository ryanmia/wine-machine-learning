function model=learn_logistic_regression_model(data,data_labels)
    alpha=1;
    epsilon=1e-6;
    num_thetas=size(data,2);
    %random starter values between -1 and 1
    thetas=-1+rand(num_thetas,1)*(1-(-1));
    prev_err=0;
    cur_err=calculate_error_logreg(thetas,data,data_labels);
    
    while abs(cur_err-prev_err)>epsilon
        new_thetas=zeros(num_thetas,1);
        for i=1:num_thetas
            new_thetas(i)=thetas(i)-alpha*derivative_logreg(i,thetas,data,data_labels);
        end
        thetas=new_thetas;
        prev_err=cur_err;
        cur_err=calculate_error_logreg(thetas,data,data_labels)
        if cur_err>prev_err
            alpha=alpha/10;
        end
    end
    model=thetas;
end