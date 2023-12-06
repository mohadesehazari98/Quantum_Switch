function [y] = find_numLink(k_total, L, L_inter_Repeater)
%--------------------------------------------------------------------------
% This function finds the most efficient resource allocation, searching through the possibilities and return the one with the highest E2E Rate
N = 10000;
sigGKP=0.12;
etad=0.99;
round_num = 4;

v_simulated = [7,6,5,4,3] .* (sqrt(pi)/20);
v = [v_simulated(L(1)==L_inter_Repeater), v_simulated(L(2)==L_inter_Repeater)];

k1 = (1:1:(k_total-1))';
k2 = zeros(length(k1),1);
for i=1:length(k1)
     k2(i) = k_total - k1(i);
end
K = [k1,k2];
clear k1 k2 i L_inter_Repeater v_simulated
%--------------------------------------------------------------------------
% Two discard windows 
ErrProb3Sigma = [LogErrAfterPost(sqrt(3*sigGKP^2 + (1-etad)/etad),v(1)),...
    LogErrAfterPost(sqrt(3*sigGKP^2 + (1-etad)/etad),v(2))];
ErrProb2Sigma = [LogErrAfterPost(sqrt(2*sigGKP^2 + (1-etad)/etad),0.7*v(1)),...
    LogErrAfterPost(sqrt(2*sigGKP^2 + (1-etad)/etad),0.7*v(2))];
%--------------------------------------------------------------------------
K = [K,zeros(size(K,1),1)];
[ZerrInner_1, XerrInner_1, sTotal_1] = Inner_Sim(N, max(L), sigGKP, etad, round_num, ErrProb3Sigma(1), ErrProb2Sigma(1));
[ZerrInner_2, XerrInner_2, sTotal_2] = Inner_Sim(N, max(L), sigGKP, etad, round_num, ErrProb3Sigma(2), ErrProb2Sigma(2));

for j = 1:size(K,1)
    K(j,3) = Combine_InnerOuter(N, K(j,1:2), L, sigGKP, etad, ErrProb3Sigma, ErrProb2Sigma,...
        ZerrInner_1, XerrInner_1, sTotal_1,...
        ZerrInner_2, XerrInner_2, sTotal_2);
    disp(['Calculating Rate at j=' num2str(j)])
end

clear j
% The allocation 
max_index = K(:,3) == max(K(:,3));
y = [L,...
    K(max_index,1)/k_total,...
    K(max_index,3)/min(K(max_index,1),K(max_index,2))];
%--------------------------------------------------------------------------
end
