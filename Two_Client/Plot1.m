LineW=2;
Name = ['K_{total} = 10'; 'K_{total} = 20'; 'K_{total} = 50'];
for i = 1:length(k_total)
    figure('Name',Name(i,:),'NumberTitle','off');
    hold on
    for j = 1:size(l1_l2,1)
        txt = ['L_{1} = L_{2} = ',num2str(The_Matrix(j,1,i))];
        stem(The_Matrix(j,2,i),...
            The_Matrix(j,3,i),...
            'LineWidth',LineW,'DisplayName',txt)  % scatter plot (2D)
        view(90,90)
    end
    hold off
    title(['K_{total} = ' num2str(k_total(i))])
    ax = gca;
    xlabel('K_{1}/K_{total}', 'FontSize', 12);
    ax.XAxis.LineWidth = 2;
    
    ylabel('Rate', 'FontSize', 12)
    ax.YAxis.LineWidth = 2;
    
    xlim([0.4 0.6])
    ylim([0 1])
    
    grid on
    ax.GridLineStyle = '-';
    ax.GridAlpha = 1; % maximum line opacity
    grid minor
    legend show
end

