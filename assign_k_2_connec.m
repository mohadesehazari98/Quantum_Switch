function [k_vector] = assign_k_2_connec(user, k_total)
% each elementary connection can have at least 2 links

[C{1:user}] = ndgrid(2:(k_total-(user-1)*2));
C = cell2mat(cellfun(@(x)(reshape(x,[],1)),C,'UniformOutput',false));
k_vector = C(sum(C,2) == k_total,:);

j=1;
while 1
    for i=1:user
        if mod(k_vector(j,i),2)==1
        k_vector(j,:)=[];
        j=j-1;
        break
        end
    end
    if j==size(k_vector,1)
        break
    end
    j=j+1;
end

end