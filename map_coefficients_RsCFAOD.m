clear all

%load('H:\final_project_23\data\stat\CFonly_3067\GWR_cross_21tif_data.mat');
% load('H:\final_project_23\data\stat\CFAODonly_67\GWR_cross_21tif_data.mat');
load('H:\final_project_25\data\quhua_extract_122_CF\GWR_cross_21tif_data122_quhua_CFAOD.mat');
%index1=[6,6,7,7;4,5,4,5];
index1=[8,8,9,9;12,14,12,14];
xlabes={'(a) Obs Rs-CF','(b) Obs Rs-AOD','(c) SunDu Rs-CF','(d) SunDu Rs-AOD'};
ylabes={'GWR CF derived Rs','GWR CF and AOD derived Rs','OLS CF derived Rs','OLS CF and AOD derived Rs'};
figure;
%set (gcf,'Position',[500,500,800,800], 'color','w');
%scrsz = get(0,'ScreenSize');
%figure('Position',[5 scrsz(4)/2 scrsz(3) scrsz(4)/2]);
ha = tight_subplot(2,2,[.05 .05],[.05 .06],[.05 .05]);
stat_tables_1=ones(4,5)*NaN;


lonx=reshape(datmat(:,2,1),length(datmat(:,2,1)),1); %lon
latx=reshape(datmat(:,3,1),length(datmat(:,3,1)),1); %lat
RR=ones(length(lonx),4)*NaN;
for tyi=1:4 
for iin=1:length(lonx)
    
    ms=reshape(datmat(iin,index1(1,tyi),:),length(datmat(iin,index1(1,tyi),1))*202,1);
    ms_ref=reshape(datmat(iin,index1(2,tyi),:),length(datmat(iin,index1(2,tyi),1))*202,1);
    ms1=ms;
    ms_ref1=ms_ref;
%     for i=1:12
%          tx=find(xyname(:,2)==i);        
%          ms1(tx)=ms(tx)-nanmean(ms(tx));
%          ms_ref1(tx)=ms_ref(tx)-nanmean(ms_ref(tx));
%     end
    
    
    ms1(ms1<=0)=NaN;
    ms_ref1(ms_ref1<=0)=NaN;
    t=find(~isnan(ms1) & ~isnan(ms_ref1));
    cer=ms1(t);
    obb=ms_ref1(t);
    utemp=corrcoef(obb,cer);
    RR(iin,tyi)=utemp(1,2);


end
end

for iin=1:4
    axes(ha(iin));
    domain = [70 160 10 60];
    load 'H:\final_project_25\china.mat'
    load coast
    plot(long,lat,'color',[.5 .5 .5]);
    hold on
    
    scatter(lonx,latx,15,RR(:,iin),'fill');
    

    caxis([-1,1]);
    axis([70 150 10 60]);
    %set(gca,'XLim',[0 1.5]);%X轴的数据显示范围
    %set(gca,'XTick',[0:0.1:1.5]);%设置要显示坐标刻度
    %set(gca,'XTickLabel',[0:0.1:1.5]);%给坐标加标签 

    text(75,55,cell2mat(xlabes(iin)),'fontsize',14,'Fontname', 'Arial'); 
    %c = redblue(100);
    plot(china.long,china.lat,'color',[.5 .5 .5]);
    hold on
    m=colorbar;
%   set(get(h,'Title'),'string','W/m^2','FontSize',14,'Fontname', 'Arial');
    set(gca,'FontSize',12,'Fontname', 'Arial'); 
    
    daspect([1,1,1]);
end
