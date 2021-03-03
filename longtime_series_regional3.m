clear all
load('G:\final_project_25\data\quhua_extract_122\GWR_cross_21tif_data122_quhua.mat');
%load('H:\final_project_23\data\stat\OLS_CFAOD\GWR_cross_21tif_dataCFAOD.mat');
%load('S:\final_project_17\data\obs\2400_select_data.mat');
%indxc=[1992,1981,1984,1988,1989,1991,2000,2013];
datmat1=datmat;

years=unique(xyname(:,1));

datmat_yr=ones(97,7,length(years));
indxc=[5,6,7,8,9,10,11];

for in=1:7 
    for i=1:length(years)
       t=find(xyname(:,1)==years(i));
        if(~isempty(t))
           datmat_yr(:,in,i)=nanmean(datmat1(:,indxc(in),t),3);
        end
    end
end
tyr=find(years==2010);
iddsites=find(datmat(:,1,1)==52418|datmat(:,1,1)==56043|datmat(:,1,1)==56029);
datmat_yr(iddsites,1,tyr)=NaN;

regialsers=ones(9,7,length(years))*NaN;
for regi=1:9
    t=find(datmat1(:,4,1)==regi);
    regialsers(regi,:,:)=nanmean(datmat_yr(t,:,:),1);
end

 regialsers1(1,:,:)=regialsers(1,:,:)-repmat(nanmean(regialsers(1,:,:),3),1,1,length(regialsers(1,1,:)));
 regialsers1(2,:,:)=regialsers(2,:,:)-repmat(nanmean(regialsers(2,:,:),3),1,1,length(regialsers(1,1,:))); 
 regialsers1(3,:,:)=regialsers(3,:,:)-repmat(nanmean(regialsers(3,:,:),3),1,1,length(regialsers(1,1,:))); 
 regialsers1(4,:,:)=regialsers(4,:,:)-repmat(nanmean(regialsers(4,:,:),3),1,1,length(regialsers(1,1,:)));
 regialsers1(5,:,:)=regialsers(5,:,:)-repmat(nanmean(regialsers(5,:,:),3),1,1,length(regialsers(1,1,:)));
 regialsers1(6,:,:)=regialsers(6,:,:)-repmat(nanmean(regialsers(6,:,:),3),1,1,length(regialsers(1,1,:)));
 regialsers1(7,:,:)=regialsers(7,:,:)-repmat(nanmean(regialsers(7,:,:),3),1,1,length(regialsers(1,1,:)));
 regialsers1(8,:,:)=regialsers(8,:,:)-repmat(nanmean(regialsers(8,:,:),3),1,1,length(regialsers(1,1,:)));
 regialsers1(9,:,:)=regialsers(9,:,:)-repmat(nanmean(regialsers(9,:,:),3),1,1,length(regialsers(1,1,:)));
axeind=[1,3,5;2,4,6];
endji=[1,6;7,8];

figure;
%set (gcf,'Position',[500,500,800,800], 'color','w');
%scrsz = get(0,'ScreenSize');
%figure('Position',[5 scrsz(4)/2 scrsz(3) scrsz(4)/2]);
ha = tight_subplot(3,3,[.05 .05],[.05 .06],[.07 .07]);

colortable1=[[0,0,0];[0,0.8,0];[1,0,0];[0,0.6,1];[0,0,1];[0,1,0];[0,0.6,0];[0.6,0,1];];      
%markers = {'-x','-o','-+','-*','-d','-^','-s','->','-.','-',}; 
markers = {'-o','-o','-d','-d','-d','-d','-s','->','-.','-',}; 
 title={'Obs','SunDu','CERES',...
        'GWR-CF','GWR-CF-AOD'...
       };  
   
 %rtext={'青藏地区','南方地区','西北地区','北方地区','','','','',''};
%   rtext={'中部干旱半干旱区（青海地区）','北部干旱半干旱区（新疆北部）','东北平原','四川盆地及周边','云贵高原及中国南部',...
%       '长江中下游平原','黄土高原及周边',...
%       '青藏高原','华北平原'}; 
%     rtext={'(a) Central arid and semiarid region','(b) Northern arid and semiarid region','(c) Northeast China Plain',...
%         '(d) Sichuan Basin and surrounding regions','(e) Yunnan-Guizhou Plateau and southern China',...
%       '(f) Middle-lower Yangtze Plain','(g) Loess Plateau and surrounding regions',...
%       '(h) Qinghai-Tibet Plateau ','(i)North China Plain and surrounding regions'}; 
      rtext={'(a) I zone','(b) II zone','(c) III zone',...
        '(d) IV zone','(e) V zone',...
      '(f) VI zone','(g) VII zone',...
      '(h) VIII zone','(i)IX zone'}; 
  indxc=[5,6,7,8,11];
for xkj=1:9
    axes(ha(xkj));
for i_in=1:length(indxc)

       x=years;
       y=reshape(regialsers1(xkj,i_in,:),length(regialsers1(xkj,i_in,:)),1);

%        hAx=plot(x,y,cell2mat(markers(i_in)),'color',colortable1(i_in,:),'LineWidth',1.5,'markersize',8);           
      hAx=plot(x,y,'-o','color',colortable1(i_in,:),'LineWidth',1.5,'markersize',5); 
       hold on
       if(i_in==length(indxc))
      %  text(2001,180,[cell2mat((rtext(xkj)))],'FontSize',12,'Fontname', 'Arial');
           text(2002,0,[cell2mat((rtext(xkj)))],'FontSize',16,'Fontname', 'Arial');
         % columnlegend(2, title, 'location','northwest');
          h=legend(title);
          set(h,'Fontsize',12,'Fontname', 'Arial'); 
          xlim([2001,2016]);
          %ylim([-20,20]);
       end
end
set(gca,'FontSize',12,'Fontname', 'Arial'); 
end


xlabel('Year','fontsize',16,'Fontname', 'Arial');
ylabel('Annual anomaly surface solar radiation W/m^2','fontsize',16,'Fontname', 'Arial');


%set(gca,'FontSize',16,'Fontname', 'Arial'); 


