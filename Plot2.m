List = [10,20,50];
Name = ['K_{total} = 10'; 'K_{total} = 20'; 'K_{total} = 50'];
for i = 1:3
    figure('Name',Name(i,:),'NumberTitle','off');

    M = The_Matrix_all(:,:,i);
   
    x = M(:,1) ./ (M(:,1) + M(:,2));
    y = M(:,3);
    
    sz = 500 .* (1 ./ (M(:,1) + M(:,2)));
    color = (M(:,1) + M(:,2));
    scatter(x,y,sz,color,'filled')
    hold on
    index = M(:,4) == max(M(:,4));
    s = scatter(M(index,1) ./ (M(index,1) + M(index,2)), M(index,3), 1000,'d','r');
    s.LineWidth = 1.5;
    hold off
    
    colormap(parula)
    c = colorbar;
    c.Label.String = 'L_{total}';
    c.Label.FontSize = 12;
    
    title(['K_{total} = ' num2str(List(i))]);
    ax = gca;
    
    xlabel('L_{1}/L_{total}');
    ax.XAxis.LineWidth = 2;
    ylabel('K_{1}/K_{total}');
    ax.YAxis.LineWidth = 2;
    grid on 
    ax.GridLineStyle = '-';
    ax.GridAlpha = 1; % maximum line opacity
    grid minor
    
    ylim([0.4 0.6])
end

