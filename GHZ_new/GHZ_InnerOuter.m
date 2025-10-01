function [Zerr,Xerr,sTotal] = GHZ_InnerOuter(L,max_L,N,k)
%--------------------------------------------------------------------------
L_inter_Repeater = [0.5,1,2,2.5,5];
v_simulated = [7,6,5,4,3] .* (sqrt(pi)/20);
sigGKP=0.12; etad=0.99;round_num=4;

%Inner Leaves 
v = v_simulated(L==L_inter_Repeater);
ErrProb3Sigma = LogErrAfterPost(sqrt(3*sigGKP^2 + (1-etad)/etad),v);
ErrProb2Sigma = LogErrAfterPost(sqrt(2*sigGKP^2 + (1-etad)/etad),0.7*v);

[ZerrInner, XerrInner, sTotal] = Inner_Sim(N, max_L, sigGKP, etad,...
    round_num, ErrProb3Sigma, ErrProb2Sigma);

ZerrInnerMat = ZerrInner .* ones(k,1);
XerrInnerMat = XerrInner .* ones(k,1);
%--------------------------------------------------------------------------

%Outer Leaves - Data Center
ErrProb3Sigma = LogErrAfterPost(sqrt(3*sigGKP^2 + (1-etad)/etad),v);
ErrProb2Sigma = LogErrAfterPost(sqrt(2*sigGKP^2 + (1-etad)/etad),0.7*v);
XerrOuter = zeros(k,1);
ZerrOuter = zeros(k,1);

for j = 1:N
    logErrOuter = OuterLeaves(L, sigGKP, etad, k, ErrProb3Sigma, ErrProb2Sigma);
    ZerrOuter = ZerrOuter + logErrOuter(:,1);
    XerrOuter = XerrOuter + logErrOuter(:,2);
end
ZerrOuterMat = ZerrOuter/N;
XerrOuterMat = XerrOuter/N;
%--------------------------------------------------------------------------
Zerr = ZerrInnerMat.*(ones(k,1) - ZerrOuterMat) + ...
    ZerrOuterMat.*(ones(k,1) - ZerrInnerMat);
Xerr = XerrInnerMat.*(ones(k,1) - XerrOuterMat) + ...
    XerrOuterMat.*(ones(k,1) - XerrInnerMat);

clear ZerrOuterMat XerrOuterMat
%--------------------------------------------------------------------------
end





    