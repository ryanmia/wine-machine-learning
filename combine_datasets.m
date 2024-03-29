function combined = combine_datasets(dataLess,dataMore)
    %%combine data here: also ensure both sets are equally representative
    equalSize=size(dataLess,1);
    dataLess = dataLess(randperm(size(dataLess, 1)), :);
    dataMore = dataMore(randperm(size(dataMore, 1)), :);
    dataMoreSubset=dataMore;%(1:equalSize,:);
    combined=[dataLess; dataMoreSubset];
    combined = combined(randperm(size(combined, 1)), :);

end

