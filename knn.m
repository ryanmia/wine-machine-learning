function predicts = knn(k,test,train,train_labels)
    predicts=zeros(size(test,2),1);
    for test_idx=1:size(test,2)
        classify=zeros(1,10);
        cur_entry=test(:,test_idx);
        dists=zeros(1,size(train,2));
        for train_idx=1:size(train,2)
            dists(train_idx)=norm(cur_entry-train(:,train_idx));
        end
        [sorted,indexes]=sort(dists);
        indexes=indexes(1:k);
        A=zeros(1,k);
        for i=1:k
            A(i)=train_labels(indexes(i));
        end
        predicts(test_idx)=mode(A);
    end
end

