function [Rate] = Inner_and_Outer(ZerrInner, XerrInner, sTotal,...
    two_combinations, k_vector_j,...
    sigGKP, etad, N, k_total, L, L_inter_Repeater, v_simulated)
%--------------------------------------------------------------------------
%Inner Leaves 
ZerrInnerMat = ZerrInner .* ones(k_total/2,1);
XerrInnerMat = XerrInner .* ones(k_total/2,1);
%--------------------------------------------------------------------------
%Outer Leaves - Data Center
user = size(two_combinations,1)+1;
l = L(user);
v = v_simulated(l==L_inter_Repeater);
ErrProb3Sigma = LogErrAfterPost(sqrt(3*sigGKP^2 + (1-etad)/etad),v);
ErrProb2Sigma = LogErrAfterPost(sqrt(2*sigGKP^2 + (1-etad)/etad),0.7*v);
[ZerrOuterMat_1, XerrOuterMat_1] = Outer_Sim(N, L, l, sigGKP, etad, (k_total/2), ErrProb3Sigma, ErrProb2Sigma,...
    1, L_inter_Repeater, v_simulated, k_vector_j, two_combinations);
%--------------------------------------------------------------------------
%Outer Leaves - User
[ZerrOuterMat_2, XerrOuterMat_2] = Outer_Sim(N, L, l, sigGKP, etad, (k_total/2), ErrProb3Sigma, ErrProb2Sigma,...
    2, L_inter_Repeater, v_simulated, k_vector_j, two_combinations);
%--------------------------------------------------------------------------
Zerr_1 = ZerrInnerMat.*(ones(k_total/2,1) - ZerrOuterMat_1) + ...
    ZerrOuterMat_1.*(ones(k_total/2,1) - ZerrInnerMat);
Xerr_1 = XerrInnerMat.*(ones(k_total/2,1) - XerrOuterMat_1) + ...
    XerrOuterMat_1.*(ones(k_total/2,1) - XerrInnerMat);

clear ZerrOuterMat_1 XerrOuterMat_1
%--------------------------------------------------------------------------
Zerr_2 = ZerrInnerMat.*(ones(k_total/2,1) - ZerrOuterMat_2) + ...
    ZerrOuterMat_2.*(ones(k_total/2,1) - ZerrInnerMat);
Xerr_2 = XerrInnerMat.*(ones(k_total/2,1) - XerrOuterMat_2) + ...
    XerrOuterMat_2.*(ones(k_total/2,1) - XerrInnerMat);

clear ZerrOuterMat_2 XerrOuterMat_2
%--------------------------------------------------------------------------
clear ZerrInnerMat XerrInnerMat
Rate = SecretKey6StateEndToEnd(...
    Zerr_1,...
    Xerr_1,...
    Zerr_2,...
    Xerr_2,...
    sTotal, sTotal, k_total/2);
end





    