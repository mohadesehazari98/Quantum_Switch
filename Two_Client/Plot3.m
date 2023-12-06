x = cell(length(k_total),1);
L = cell(length(k_total),1);
for j=1:length(k_total)
    x{j} = single(The_Matrix_all(:,3,j) .* k_total(j)) - (k_total(j)/2);
    L{j} = The_Matrix_all(:,1,j) + The_Matrix_all(:,2,j);
end

ctrs = min(x{length(k_total)}):max(x{length(k_total)});
cnt=zeros(length(k_total),length(ctrs));
mean_L = zeros(length(k_total),length(ctrs));

for j=1:length(k_total)
    for i=1:length(ctrs)
        mean_L(j,i)=mean(L{j}(x{j}==ctrs(i)));
        if isnan(mean_L(j,i))
            mean_L(j,i)=0;
        end
    end
end



