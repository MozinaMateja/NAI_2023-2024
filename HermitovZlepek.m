function y = HermitovZlepek(f,df,ddf,X,x)
l = (length(X)-1);
d = cell(1,l);
for i = 1:l
    [~,g] = HermitovPolinom(f,df,ddf,X(i),X(i+1),X(1));
    d{i} = g;
end

y = [];
for j = 1:length(x)
    for k = 1:l
        if x(j) >= X(k)
            y(j) = d{k}(x(j));
        end
    end
end