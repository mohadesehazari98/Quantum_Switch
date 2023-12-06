L_inter_Repeater = [0.5,1,2,2.5,5];

%N=length(L_inter_Repeater); K=2;
%P=nchoosek(1:N,K);P=reshape(P(:,perms(1:K)),[],K);
%l1_l2 = [L_inter_Repeater(P);(L_inter_Repeater)' * ones(1,2)];

l1_l2 = (L_inter_Repeater)' * ones(1,2);
clear K N P

k_total = [10,20,50];
The_Matrix = zeros(size(l1_l2,1), 4, length(k_total));
for j=1:length(k_total)
    for i=1:size(l1_l2,1)
        The_Matrix(i,:,j) = find_numLink(k_total(j), l1_l2(i,:), L_inter_Repeater);
        disp('the [L1, L2, k1/k_total, Rate_max are:');
        disp(The_Matrix(i,:,j));
    end
end




