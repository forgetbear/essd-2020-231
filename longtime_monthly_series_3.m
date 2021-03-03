clear all
load('H:\final_project_25\data\stat\stat_shp\GWR_cross_21tif_data122_2_addCERESdeng.mat');
%load('H:\final_project_23\data\stat\OLS_CFAOD\GWR_cross_21tif_dataCFAOD.mat');
%load('S:\final_project_17\data\obs\2400_select_data.mat');
%indxc=[1992,1981,1984,1988,1989,1991,2000,2013];
fileoutpth='H:\final_project_25\test\';
datmat_obs=reshape(datmat(:,4,:),length(datmat(:,4,1)),length(datmat(1,4,:)));
datmat_sunDu=reshape(datmat(:,5,:),length(datmat(:,5,1)),length(datmat(1,5,:)));
datmat_ceres=reshape(datmat(:,6,:),length(datmat(:,6,1)),length(datmat(1,6,:)));
datmat_gwrCF=reshape(datmat(:,7,:),length(datmat(:,7,1)),length(datmat(1,7,:)));
datmat_gwrCFAOD=reshape(datmat(:,8,:),length(datmat(:,8,1)),length(datmat(1,8,:)));
datmat_OLSCF=reshape(datmat(:,9,:),length(datmat(:,9,1)),length(datmat(1,9,:)));
datmat_OLSCFAOD=reshape(datmat(:,10,:),length(datmat(:,10,1)),length(datmat(1,10,:)));

datmat_CF=reshape(datmat(:,11,:),length(datmat(:,11,1)),length(datmat(1,11,:)));
datmat_AOD=reshape(datmat(:,12,:),length(datmat(:,12,1)),length(datmat(1,12,:)));



      
indxc=find(datmat(:,1,1)==54161|...
  datmat(:,1,1)==59644);

%indxc=[29,39];
[lox,loy]=size(indxc);
datmat_ceres(2013,129)=292.237;
%sites=[[79.9833,32.1833];[84.4167,32.15];[81.25,30.2833]];
%sites=[[82.7667,37];[83.8333,37.6];[85.5333,38.1333]];

%colortable=[[1,0.3,0];[1,0.8,0];[0,0.8,0];[0,0,0];[0,0.4,1];];

colortable=[[0,0,0];[0.5,0.5,0.5];[1,0,0];[0,0.6,1];[0,0,1];[0,1,0];[0,0.6,0];[0.6,0,1];];

markers = {'-x','-o','-+','-*','-d','-^','-s','->','-.','-',}; 

figure;
%set (gcf,'Position',[500,500,800,800], 'color','w');
%scrsz = get(0,'ScreenSize');
%figure('Position',[5 scrsz(4)/2 scrsz(3) scrsz(4)/2]);
ha = tight_subplot(1,length(indxc),[.05 .05],[.05 .06],[.07 .07]);

%path_MERRA1={'S:\final_project_17\data\ERAI\GWR_test_out\ERAI_GWR_2000_2014',...
%load('S:\final_project_17\data\obs\2400_select_data.mat');
timed={ 'H:\final_project_25\time_range122.csv'};
timedx=importdata(cell2mat(timed(1)));
yearmonth1=timedx.data;
timeperiod=[1,1,1,1;202,202,202,202];
yearmonth=yearmonth1(timeperiod(1,1):timeperiod(2,1),:);
z_m=8;
uniyr=unique(yearmonth1(:,1));
uniyr=uniyr(2:end);
datax=datmat_obs(indxc,:);
image_MODIS=datax;
[xn,yn]=size(datax);
anomy_data_MODIS=zeros(length(indxc),9,12)*NaN;    
for xi=1:length(indxc)
    for yri=1:12
       t=find(yearmonth(:,2)==yri);
       if(~isempty(t))
           anomy_data_MODIS(xi,1,yri)=nanmean(datmat_obs(indxc(xi),t));
           anomy_data_MODIS(xi,2,yri)=nanmean(datmat_sunDu(indxc(xi),t));
           anomy_data_MODIS(xi,3,yri)=nanmean(datmat_ceres(indxc(xi),t));
           anomy_data_MODIS(xi,4,yri)=nanmean(datmat_gwrCF(indxc(xi),t));
           anomy_data_MODIS(xi,5,yri)=nanmean(datmat_gwrCFAOD(indxc(xi),t));
           anomy_data_MODIS(xi,6,yri)=nanmean(datmat_OLSCF(indxc(xi),t));
           anomy_data_MODIS(xi,7,yri)=nanmean(datmat_OLSCFAOD(indxc(xi),t));
           anomy_data_MODIS(xi,8,yri)=nanmean(datmat_CF(indxc(xi),t));
           anomy_data_MODIS(xi,9,yri)=nanmean(datmat_AOD(indxc(xi),t));
           
           
           %“Ï≥£¥¶¿Ì
           
       end   
    end
end

axeind=[1,3,5;2,4,6];
endji=[1,7;8,9];
for xkj=1:1
for i_in=1:length(indxc)
    axes(ha(i_in));
   for ij=endji(xkj,1):endji(xkj,2)
           x=1:12;
           y=anomy_data_MODIS(i_in,ij,:);
           y=reshape(y,length(y),1);
           if(xkj==1)
               hAx=plot(x,y,'-o','color',colortable(ij,:),'LineWidth',2,'markersize',8); 
               
           else
               %hAx=plot(x,y,cell2mat(markers(ij-6)),'color',colortable(ij-6,:),'LineWidth',2,'markersize',5);
               
               if(ij==7)
                   bar(x,y,'FaceColor',[0,0.8,0.8],'EdgeColor','none');
                   hold on
               else
                   bar(x,y,'FaceColor','none','EdgeColor','r');%box off 
                   %hAx=plot(x,y,cell2mat(markers(ij-6)),'color',colortable(ij-6,:),'LineWidth',2,'markersize',5);
               end

           end
%            y=anomy_data_MODIS(i_in,:,ij);   
%            x=1:length(anomy_data_MODIS(i_in,:,ij));
%            %x=yearmonth(:,1);
%            hAx=plot(x,y,cell2mat(markers(ij)),'color',colortable(ij,:),'LineWidth',1.5,'markersize',3);          
           hold on
         % set(gca,'XTick',min(yearmonth(:,1)):floor((max(yearmonth(:,1))-min(yearmonth(:,1)))/8):max(yearmonth(:,1))); 
%          if(xkj==1)
%             set(gca,'ylim',[-35 35]);
%          else
%            set(gca,'ylim',[-0.2 0.2]);
%          end
          
%          xlim([2000,2018]);
%         if(i_in~=xn)
%          set(gca,'xticklabel',{' ',' ',' ',' ',' ',' ',' ',' ',' ',' '});   
%         else
%          set(gca,'xticklabel',{'2000','2001','2003','2005','2006','2008','2010','2011','2013','2014'});
%         end
%          set(gca,'TickLength',[0.0025, 0.0025])
   end
      text(2,200,['lon:',num2str(roundn(datmat(indxc(i_in),2,1),-2)),'lat:',num2str(roundn(datmat(indxc(i_in),3,1),-2))],'FontSize',12,'Fontname', 'Arial');
%       title={'Observed Rs','CERES EBAF Rs',...
%        'GWR CF derived Rs','GWR CF and AOD derived Rs',...
%        'OLS CF derived Rs','OLS CF and AOD derived Rs'};
      title={'Direct Rs','SunDu','CERES',...
       'GWR-CF','GWR-CF-AOD',...
       'OLS-CF','OLS-CF-AOD'};     
     % columnlegend(2, title, 'location','northwest');
   
      h=legend(title);
      set(h,'Fontsize',12,'Fontname', 'Arial'); 
      ylim([50,250]);
end
set(gca,'FontSize',12,'Fontname', 'Arial'); 
end


xlabel('year','fontsize',12,'Fontname', 'Arial');
ylabel('Annual mean of monthly anomaly solar radiation W m ^-^2','fontsize',12,'Fontname', 'Arial');





