function rate = get_correct_rate(predicted,actual)
    rate=0;
    for i=1:size(predicted)
        if predicted(i)==actual(i)
            rate=rate+1;
        end
    end
    rate=rate./size(predicted,1);
end

