function [ ZerrOuter, XerrOuter ] = Outer_Sim( N, l, sigGKP, etad, k, ErrProb3Sigma, ErrProb2Sigma )
XerrOuter = zeros(k,1);
ZerrOuter = zeros(k,1);

parfor i = 1:N
    logErrOuter = OuterLeaves(l, sigGKP, etad, k, ErrProb3Sigma, ErrProb2Sigma);
    ZerrOuter = ZerrOuter + logErrOuter(:,1);
    XerrOuter = XerrOuter + logErrOuter(:,2);
end
ZerrOuter = ZerrOuter/N;
XerrOuter = XerrOuter/N;

end

