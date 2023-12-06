user=4; k_total=[24]; L_inter_Repeater=[0.5,1,2,2.5,5];
N=10000; sigGKP=0.12; etad=0.99; round_num=4;

Rate_k = cell(length(k_total),1); 
L=[5,5,5,0.5]; 

for j=1:length(k_total)
    %we only consider connections to the Data Center, and so there are n-1
    %total connections. 
    k_vector = assign_k_2_connec(user-1, k_total(j));
    Rate = zeros(size(k_vector,1),size(L,1)); 

    for i=1:size(L,1)
        L_Inner=max(L(i,:));
        Rate(:,i) = core(k_total(j), user, L(i,:), L_Inner,...
            sigGKP, etad, N, round_num);
        disp(['The Rate for k_total of' num2str(j) 'and for L of' num2str(i)])
    end
    Rate_k{j}=Rate;
end



