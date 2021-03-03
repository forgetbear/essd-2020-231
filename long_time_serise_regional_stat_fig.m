clear all
infile='J:\final_project_25\data\stat\fenqu_stat.xlsx';
timed=importdata(infile);
      rtext={'I','II','III',...
        'IV','V ',...
      'VI','VII',...
      'VIII','IX'}; 
figure;
ha = tight_subplot(3,3,[.05 .05],[.07 .07],[.07 .07]);

for iout=1:9
    axes(ha(iout));
    
    b=bar(timed(1+3*(iout-1):3+3*(iout-1),[3,4,5]));

    grid on;
    hold on
    set(gca,'XGrid','off');
    ch = get(b,'children');
    set(gca,'XTickLabel',{'S-D','C-D','S-C'});
    
%      xtl=get(gca,'XTickLabel'); 
%      % 获取xtick的值
%      xt=get(gca,'XTick'); 
%     % 获取ytick的值         
%     yt=get(gca,'YTick');   
%     % 设置text的x坐标位置们         
%     xtextp=xt;                   
%      % 设置text的y坐标位置们      
%      ytextp=(yt(1)-0.2*(yt(2)-yt(1)))*ones(1,length(xt)); 
%     % rotation，正的旋转角度代表逆时针旋转，旋转轴可以由HorizontalAlignment属性来设定，
%     % 有3个属性值：left，right，center
%      text(xtextp,ytextp,xtl,'HorizontalAlignment','right','rotation',45,'fontsize',12); 
%     % 取消原始ticklabel
%      set(gca,'xticklabel','');
    
    
    text(1,6,cell2mat(rtext(iout)),'HorizontalAlignment','right','rotation',0,'fontsize',12); 
    % set(ch,'FaceVertexCData',[1 0 1;0 0 0;])
    ylim([0 7]);
    % set(gca,'YTick',1:1:11);
    %set(gca,'YTickLabel',{'0%','10%','20%','30%','40%','50%','60%','70%','80%','90%','100%'});
    legend('MAB','Std','RMSE');
    %xlabel('种群规模');
    %ylabel('优化结束百分数');
    c = jet(10);
    colormap(c);

end