function [k_vector] = assign_k2client(client, k_total)
% each elementary connection can have at least 2 links

[C{1:client}] = ndgrid(1:(k_total-client+1));
C = cell2mat(cellfun(@(x)(reshape(x,[],1)),C,'UniformOutput',false));
k_vector = C(sum(C,2) == k_total,:);
end