function [] = graphplot(A,txt,num,leg)
    [m,~] = size(A);
    c = colorscl(txt{7,1},A,num(16,1));
    fig = figure('Color', 'White', 'Units', 'Centimeter', 'Position', [num(1,1) num(2,1) num(3,1) num(4,1)], 'Visible', txt{5,1});
    for i=1:m
        if (~isempty(leg{i,4}))
            c(i,1) = leg{i,4}(1,1);
            c(i,2) = leg{i,5}(1,1);
            c(i,3) = leg{i,6}(1,1);
        end
        if (i==1)
            alt(i,1) = plot(A{i,1}(:,1),A{i,1}(:,2),string(leg{i,2}),'Color',c(i,:),'MarkerSize',leg{i,7}(1,1),...
                'MarkerEdgeColor',[leg{i,8}(1,1) leg{i,9}(1,1) leg{i,10}(1,1)],...
                'MarkerFaceColor',[leg{i,11}(1,1) leg{i,12}(1,1) leg{i,13}(1,1)]);  
            set(alt(i,1),'LineWidth',leg{i,3}(1,1));
        else
            alt(i,1) = errorbar(A{i,1}(:,2),A{i,1}(:,1),A{i,1}(:,3),string(leg{i,2}),'horizontal','Color',c(i,:),'MarkerSize',leg{i,7}(1,1),...
                'MarkerEdgeColor',[leg{i,8}(1,1) leg{i,9}(1,1) leg{i,10}(1,1)],...
                'MarkerFaceColor',[leg{i,11}(1,1) leg{i,12}(1,1) leg{i,13}(1,1)]);  
            set(alt(i,1),'LineWidth',leg{i,3}(1,1));
        end
        hold on
    end
    xlim([num(9,1) num(10,1)]);
    ylim([num(11,1) num(12,1)]);
    set(gca,'FontSize',num(6,1), 'FontName', txt{8,1});
    if (~isempty(txt{2,1}))
        t = title(char(txt{2,1}),'FontName', txt{8,1}','FontSize',num(5,1));
        x = xlabel(char(txt{3,1}),'FontName', txt{8,1},'FontSize',num(5,1));
        y = ylabel(char(txt{4,1}),'FontName', txt{8,1},'FontSize',num(5,1));
        set([x y t], 'interpreter', 'latex');
    else
        x = xlabel(char(txt{3,1}),'FontName', txt{8,1},'FontSize',num(5,1));
        y = ylabel(char(txt{4,1}),'FontName', txt{8,1},'FontSize',num(5,1));
        set([x y], 'interpreter', 'latex');
    end
    box_vars(1:m) = alt(1:m,1);
    hLegend = legend(box_vars(1:m), char(leg{1:m,1}),'FontName', txt{8,1}, 'Box',txt{9,1},'fontsize',num(7,1));  
    set(hLegend, 'Location',txt{10,1},'Orientation',txt{11,1},'interpreter', 'latex');
    hLegend.NumColumns = num(8,1);
    ax = gca;
    ax.Box = txt{6,1};
    ax.XTick = num(9,1):num(13,1):num(10,1);
    ax.YTick = num(11,1):num(14,1):num(12,1);
    ax.XGrid = txt{12,1};
    ax.YGrid = txt{13,1};
    ax.GridLineStyle = txt{14,1};
    ax.GridColor = 'k';
    ax.GridAlpha = num(15,1);
%     ax.YAxis.Exponent = -3;
    formatfigure1 = strcat(txt{1,1}, '.emf'); 
    saveas(fig, string(formatfigure1));
    formatfigure2 = strcat(txt{1,1}, '.svg'); 
    saveas(fig, string(formatfigure2));
end