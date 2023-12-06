function [Rate] = core(k_total, k_vector, user, L, L_Inner, sigGKP, etad, N, round_num)

comb_vec = two_combinations(user);
L_inter_Repeater = [0.5,1,2,2.5,5];
v_simulated = [7,6,5,4,3] .* (sqrt(pi)/20);
%--------------------------------------------------------------------------
%Inner Leaves
%The window that we choose is the average over all user's efficient window
%size
v = v_simulated(L_Inner==L_inter_Repeater);
ErrProb3Sigma = LogErrAfterPost(sqrt(3*sigGKP^2 + (1-etad)/etad),v);
ErrProb2Sigma = LogErrAfterPost(sqrt(2*sigGKP^2 + (1-etad)/etad),0.7*v);

[ZerrInner, XerrInner, sTotal] = Inner_Sim(N, max(L), sigGKP, etad,...
    round_num, ErrProb3Sigma, ErrProb2Sigma);
%--------------------------------------------------------------------------
%Outer Leaves
Rate = zeros(size(k_vector,1),1);
for j=1:size(Rate,1)
    Rate(j) = Inner_and_Outer(ZerrInner, XerrInner, sTotal,...
    comb_vec, k_vector(j,:),...
    sigGKP, etad, N, k_total, L, L_inter_Repeater, v_simulated);
end
%--------------------------------------------------------------------------
Rate = Rate ./ (k_total/2);
end





