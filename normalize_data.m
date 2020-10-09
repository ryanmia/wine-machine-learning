function res=normalize_data(data)
%%insert normalization here: normalize 0-1 so weighting is equal
    res=[];
    for i=1:size(data,2)
        col=data(:,i);
        col=normalize(col,'range');
        res=[res col];
    end
end

