function out = SecretKey6StateEndToEnd(Zerr_1, Xerr_1, Zerr_2, Xerr_2, sTotal_1, sTotal_2, k)

parfor i = 1:numel(Zerr_1)
    if Zerr_1(i) > 0.5
        Zerr_1(i) = 0.5;
    end

    if Xerr_1(i) > 0.5
        Xerr_1(i) = 0.5;
    end
end

parfor i = 1:numel(Zerr_2)
    if Zerr_2(i) > 0.5
        Zerr_2(i) = 0.5;
    end

    if Xerr_2(i) > 0.5
        Xerr_2(i) = 0.5;
    end
end

NoLinks = 2;
Zerr = cell(2,1);Zerr{1,1}=Zerr_1;Zerr{2,1}=Zerr_2;
Xerr = cell(2,1);Xerr{1,1}=Xerr_1;Xerr{2,1}=Xerr_2;
sTotal = cell(2,1); sTotal{1,1}=sTotal_1;sTotal{2,1}=sTotal_2;

QerrZArray = zeros(k, 2^(NoLinks));
QerrXArray = zeros(k, 2^(NoLinks));
pZ = zeros(1,2^(NoLinks));
pX = zeros(1,2^(NoLinks));

binary_m = dec2bin(0:1:2^(NoLinks)-1);
%For each bin we calculate the corresponding error and the corresponding
%probability.
for i=1:2^(NoLinks)
    m=[str2double(binary_m(i,1)),str2double(binary_m(i,2))];
    MultiZ=1;
    MultiX=1;
    MultipZ=1;
    MultipX=1;
    for j=1:NoLinks
        MultiZ = MultiZ .* ((1 - 2 * Zerr{j,1}(1:k,2)).^(m(j))) .* ((1 - 2 * Zerr{j,1}(1:k,1)).^(1-m(j)));
        MultiX = MultiX .* ((1 - 2 * Xerr{j,1}(1:k,2)).^(m(j))) .* ((1 - 2 * Xerr{j,1}(1:k,1)).^(1-m(j)));
        MultipZ = MultipZ .* ((sTotal{j,1}(1)).^(m(j))) .* ((1-sTotal{j,1}(1)).^(1-m(j))); 
        MultipX = MultipX .* ((sTotal{j,1}(2)).^(m(j))) .* ((1-sTotal{j,1}(2)).^(1-m(j)));
    end
    QerrZArray(:,i) = (1 - MultiZ)/2;
    QerrXArray(:,i) = (1 - MultiX)/2;
    pZ(i) = MultipZ; 
    pX(i) = MultipX;
end

% 
SecKeyTotal = 0;
for i = 0:(2^NoLinks-1)
    for j = 0:(2^NoLinks-1)
        SecKeyTotal = SecKeyTotal + pZ(i+1)*pX(j+1)*SecretKey6State(QerrZArray(:,i+1), QerrXArray(:,j+1));
    end
end

out = SecKeyTotal;

end