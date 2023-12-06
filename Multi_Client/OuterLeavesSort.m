function [ logErrOuterMat ] = OuterLeavesSort( L, sigGKP, etad, L_inter_Repeater, v_simulated,...
    k_vector_j, two_combinations)

logErrOuter = cell(size(two_combinations,1),1);
for i=1:size(two_combinations,1)
    l = L(two_combinations(i,1));
    v = v_simulated(l==L_inter_Repeater);
    ErrProb3Sigma = LogErrAfterPost(sqrt(3*sigGKP^2 + (1-etad)/etad),v);
    ErrProb2Sigma = LogErrAfterPost(sqrt(2*sigGKP^2 + (1-etad)/etad),0.7*v);
    
    logErrOuter{i} = OuterLeaves(l, sigGKP, etad, (k_vector_j(i)/2), ErrProb3Sigma, ErrProb2Sigma);
end
logErrOuterMat = cell2mat(logErrOuter);
[logErrOuterMat,~] = sortrows(logErrOuterMat, -3);

end

