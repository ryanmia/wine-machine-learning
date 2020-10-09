function res=feature_extraction(data,addColor)
%%feature extract here: add red versus white, remove quality
    res=data(:,1:end-1);
    newCol=zeros(size(res,1),1)+addColor;
    res=[res newCol];
    
end

