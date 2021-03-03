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
%      % ��ȡxtick��ֵ
%      xt=get(gca,'XTick'); 
%     % ��ȡytick��ֵ         
%     yt=get(gca,'YTick');   
%     % ����text��x����λ����         
%     xtextp=xt;                   
%      % ����text��y����λ����      
%      ytextp=(yt(1)-0.2*(yt(2)-yt(1)))*ones(1,length(xt)); 
%     % rotation��������ת�Ƕȴ�����ʱ����ת����ת�������HorizontalAlignment�������趨��
%     % ��3������ֵ��left��right��center
%      text(xtextp,ytextp,xtl,'HorizontalAlignment','right','rotation',45,'fontsize',12); 
%     % ȡ��ԭʼticklabel
%      set(gca,'xticklabel','');
    
    
    text(1,6,cell2mat(rtext(iout)),'HorizontalAlignment','right','rotation',0,'fontsize',12); 
    % set(ch,'FaceVertexCData',[1 0 1;0 0 0;])
    ylim([0 7]);
    % set(gca,'YTick',1:1:11);
    %set(gca,'YTickLabel',{'0%','10%','20%','30%','40%','50%','60%','70%','80%','90%','100%'});
    legend('MAB','Std','RMSE');
    %xlabel('��Ⱥ��ģ');
    %ylabel('�Ż������ٷ���');
    c = jet(10);
    colormap(c);

end