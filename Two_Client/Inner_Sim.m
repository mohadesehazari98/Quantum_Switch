function [ZerrInner, XerrInner, sTotal] = Inner_Sim(N, L, sigGKP, etad, n, ErrProb3Sigma, ErrProb2Sigma)

XerrInner = zeros(1,2);
ZerrInner = zeros(1,2);
sTotal = zeros(1,2);

%Simulate inner leaves
parfor i = 1:N
    [logErrInner, s] = InnerLeaves(L, sigGKP, etad, n, ErrProb3Sigma, ErrProb2Sigma);
    tZ = zeros(1,2);
    tX = zeros(1,2);

    if s(1)==0
        tZ(1) = tZ(1) + logErrInner(1);
    else
        tZ(2) = tZ(2) + logErrInner(1);
    end
    if s(2)==0
        tX(1) = tX(1) + logErrInner(2);
    else
        tX(2) = tX(2) + logErrInner(2);
    end

    ZerrInner = ZerrInner + tZ;
    XerrInner = XerrInner + tX;
    sTotal = sTotal + s;
end

ZerrInner = ZerrInner./[N-sTotal(1), sTotal(1)];
XerrInner = XerrInner./[N-sTotal(2), sTotal(2)];
sTotal = sTotal/N;

end