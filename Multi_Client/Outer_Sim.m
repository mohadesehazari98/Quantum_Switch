function [ZerrOuter_1, XerrOuter_1, ZerrOuter_2, XerrOuter_2] = Outer_Sim(...
    L, L_inter_Repeater, v_simulated, sigGKP, etad, comb_vec, k_vector_j,...
    N)

% Keeping track of each end-user link 
v = v_simulated(max(L)==L_inter_Repeater);
ErrProb3Sigma = LogErrAfterPost(sqrt(3*sigGKP^2 + (1-etad)/etad),v);
ErrProb2Sigma = LogErrAfterPost(sqrt(2*sigGKP^2 + (1-etad)/etad),0.7*v);
%initialization
ZerrOuterMat_1 = 0;
XerrOuterMat_1 = 0;
ZerrOuterMat_2 = 0;
XerrOuterMat_2 = 0;

%Outer syndrome
parfor i = 1:N
    %LogErrOuter
    logErrOuter_1 = OuterLeavesSort( L, sigGKP, etad, L_inter_Repeater, v_simulated,...
        k_vector_j, comb_vec);
    logErrOuter_2 = OuterLeaves(max(L), sigGKP, etad, sum(k_vector_j)/2, ErrProb3Sigma, ErrProb2Sigma);
    %ZerrOuter/XerrOuter
    tmp_Zerr1=cell(3,1);
    tmp_Xerr1=cell(3,1);
    tmp_Zerr2=cell(3,1);
    tmp_Xerr2=cell(3,1);
    for j=1:size(comb_vec,1)
        tmp_Zerr1{j} = logErrOuter_1(logErrOuter_1(:,2) == j,3);
        tmp_Xerr1{j} = logErrOuter_1(logErrOuter_1(:,2) == j,4);
        tmp_Zerr2{j} = logErrOuter_2(logErrOuter_1(logErrOuter_1(:,2) == j,1),1);
        tmp_Xerr2{j} = logErrOuter_2(logErrOuter_1(logErrOuter_1(:,2) == j,1),2);
    end
    ZerrOuterMat_1 = ZerrOuterMat_1 + vertcat(tmp_Zerr1{:});
    XerrOuterMat_1 = XerrOuterMat_1 + vertcat(tmp_Xerr1{:});
    ZerrOuterMat_2 = ZerrOuterMat_2 + vertcat(tmp_Zerr2{:});
    XerrOuterMat_2 = XerrOuterMat_2 + vertcat(tmp_Xerr2{:});
end

ZerrOuter_1 = mat2cell(ZerrOuterMat_1/N, k_vector_j/2);
XerrOuter_1 = mat2cell(XerrOuterMat_1/N, k_vector_j/2);
ZerrOuter_2 = mat2cell(ZerrOuterMat_2/N, k_vector_j/2);
XerrOuter_2 = mat2cell(XerrOuterMat_2/N, k_vector_j/2);
end

