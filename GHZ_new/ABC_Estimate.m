L = [0.5,2,5];k_total=10;N=10000;
k_vector = assign_k2client(length(L), k_total);
Rate=zeros(size(k_vector,1),1);

for i=1:size(k_vector,1)
    k_list=k_vector(i,:);

    [Zerr_1,Xerr_1,sTotal_1] = GHZ_InnerOuter(L(1),max(L),N,k_list(1));
    [Zerr_2,Xerr_2,sTotal_2] = GHZ_InnerOuter(L(2),max(L),N,k_list(2));
    [Zerr_3,Xerr_3,sTotal_3] = GHZ_InnerOuter(L(3),max(L),N,k_list(3));
    
    out = SecretKey6StateGHZEndToEnd(Zerr_1, Xerr_1, Zerr_2, Xerr_2, Zerr_3, ...
        Xerr_3, sTotal_1, sTotal_2, sTotal_3, min(k_list));
    %per-mode rate
    Rate(i) = out / min(k_list);
end

ResourceDistribution=k_vector(Rate==max(Rate),:);