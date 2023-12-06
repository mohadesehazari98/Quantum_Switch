function [Rate] = Combine_InnerOuter(N, K_each, L, sigGKP, etad, ErrProb3Sigma, ErrProb2Sigma,...
    ZerrInner_1, XerrInner_1, sTotal_1,...
    ZerrInner_2, XerrInner_2, sTotal_2)
%--------------------------------------------------------------------------
k_main = min(K_each);
k_1=K_each(1);k_2=K_each(2);
l_1=L(1);l_2=L(2);
%--------------------------------------------------------------------------
%Inner Leaves
ZerrInnerMat_1 = ZerrInner_1 .* ones(k_1,1);
XerrInnerMat_1 = XerrInner_1 .* ones(k_1,1);

ZerrInnerMat_2 = ZerrInner_2 .* ones(k_2,1);
XerrInnerMat_2 = XerrInner_2 .* ones(k_2,1);

%--------------------------------------------------------------------------
[ZerrOuter_1, XerrOuter_1] = Outer_Sim(N, l_1, sigGKP, etad, k_1, ErrProb3Sigma(1), ErrProb2Sigma(1));

Zerr_1 = ZerrInnerMat_1.*(ones(k_1,1) - ZerrOuter_1) + ZerrOuter_1.*(ones(k_1,1) - ZerrInnerMat_1);
Xerr_1 = XerrInnerMat_1.*(ones(k_1,1) - XerrOuter_1) + XerrOuter_1.*(ones(k_1,1) - XerrInnerMat_1);

clear ZerrOuter_1 ZerrInnerMat_1 XerrOuter_1 XerrInnerMat_1
%--------------------------------------------------------------------------
[ZerrOuter_2, XerrOuter_2] = Outer_Sim(N, l_2, sigGKP, etad, k_2, ErrProb3Sigma(2), ErrProb2Sigma(2));

Zerr_2 = ZerrInnerMat_2.*(ones(k_2,1) - ZerrOuter_2) + ZerrOuter_2.*(ones(k_2,1) - ZerrInnerMat_2);
Xerr_2 = XerrInnerMat_2.*(ones(k_2,1) - XerrOuter_2) + XerrOuter_2.*(ones(k_2,1) - XerrInnerMat_2);

clear ZerrOuter_2 ZerrInnerMat_2 XerrOuter_2 XerrInnerMat_2
%--------------------------------------------------------------------------
Rate = SecretKey6StateEndToEnd(...
    Zerr_1,...
    Xerr_1,...
    Zerr_2,...
    Xerr_2,...
    sTotal_1,sTotal_2, k_main);

end