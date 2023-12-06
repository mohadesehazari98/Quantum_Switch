function out_vec = two_combinations(user)

General_vec = nchoosek(1:user,2);

j=1;
while 1
    if General_vec(j,1)==user
        j=j+1;
    elseif General_vec(j,2)==user
        j=j+1;
    else
        General_vec(j,:)=[];
    end
    if j==(size(General_vec,1)+1)
        break
    end
end
out_vec = General_vec;
end

