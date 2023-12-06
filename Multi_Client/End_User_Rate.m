function [Rate] = Inner_and_Outer(L_Inner, comb_vec, k_vector_j,...
    sigGKP, etad, round_num, N, L, L_inter_Repeater, v_simulated)
%--------------------------------------------------------------------------
%Inner Leaves
%The window that we choose is according to the Data Center
v = v_simulated(L_Inner==L_inter_Repeater);
ErrProb3Sigma = LogErrAfterPost(sqrt(3*sigGKP^2 + (1-etad)/etad),v);
ErrProb2Sigma = LogErrAfterPost(sqrt(2*sigGKP^2 + (1-etad)/etad),0.7*v);

[ZerrInner, XerrInner, sTotal] = Inner_Sim(N, max(L), sigGKP, etad,...
    round_num, ErrProb3Sigma, ErrProb2Sigma);
%--------------------------------------------------------------------------
%Outer Leaves
[ZerrOuter_1, XerrOuter_1, ZerrOuter_2, XerrOuter_2] = Outer_Sim(...
    L, L_inter_Repeater, v_simulated, sigGKP, etad, comb_vec, k_vector_j,...
    N);
%--------------------------------------------------------------------------
Rate = zeros(1,size(comb_vec,1));
for j =1:size(comb_vec,1)
    Rate(j) = User_Rate(ZerrInner, XerrInner, sTotal,...
        ZerrOuter_1{j}, XerrOuter_1{j}, ZerrOuter_2{j}, XerrOuter_2{j});
end

end
 