clear all
load('H:\final_project_25\data\Sundu_Derived_Rs2017.mat')

filein='G:\final_project_17\data\China_Rs_MERRA12.nc';
miantitle={'Surface Solar Radiation'};

llon = station(:,2);
llat = station(:,3);
year = date_monthly(:,1);
month1 = date_monthly(:,2);
Rs_ob1 = SD_monthly;

Rs_ob=Rs_ob1(591:end,:)';
month=month1(591:end,:)';


title={'(a) Observed Rs'};
[m,n]=size(Rs_ob);
anomy_data=zeros(m,1,3);

for ji=1:m
        anomy_data(ji,1,1)=nanmean(Rs_ob(ji,:));
end
 llon1 = min(llon):1:max(llon);
 llat1 =min(llat):1:max(llat);
 [X,Y]=meshgrid(llon1,llat1);
loca=zeros(length(llon),2)*NaN;
for chai=1:length(llon)
    tx=find(abs(X(1,:)-llon(chai))==min(abs(X(1,:)-llon(chai))));
    ty=find(abs(Y(:,1)-llat(chai))==min(abs(Y(:,1)-llat(chai))));  
    loca(chai,1)=tx(1);
    loca(chai,2)=ty(1);
end
figure;
%set (gcf,'Position',[500,500,800,800], 'color','w');
%scrsz = get(0,'ScreenSize');
%figure('Position',[5 scrsz(4)/2 scrsz(3) scrsz(4)/2]);
ha = tight_subplot(2,2,[.05 .05],[.07 .07],[.07 .07]);
for j_in=1:1
  
    axes(ha(1));
    domain = [70 160 10 60];
    load 'H:\final_project_25\china.mat'
    load coast
    plot(long,lat,'color',[.5 .5 .5]);
    hold on
%     plot(china.long,china.lat,'color',[.5 .5 .5]);
%     hold on     
   % text(100,65,cell2mat(miantitle(1)),'fontsize',18,'Fontname', 'Arial'); 
    
    ms=anomy_data(:,1,j_in)';
    ms1=ms;%(ms<0.08 & ms>-0.08);
    ms_ref=anomy_data(:,1,1)';
    llon1=llon;%(ms<0.08 & ms>-0.08);
    llat1=llat;%(ms<0.08 & ms>-0.08);
    %scatter(llon1,llat1,20,ms1,'filled');
     Z=X;
     Z(:,:)=NaN;
     [mz1,nz]=size(Z);
     for iz=1:mz1
      for jz=1:nz
         mz=find(jz==loca(:,1) & iz==loca(:,2));
         Z(iz,jz)=nanmean(ms1(mz));
      end
     end
    %surf(X,Y,Z,'EdgeColor','none');

    h=imagesc(X(1,:),Y(:,1),Z);%其中C为包含有nan的数据
    set(h,'alphadata',~isnan(Z))  
     m=colorbar;
    caxis([100,200]);
    axis([105 115 24 35]);
    %set(gca,'XLim',[0 1.5]);%X轴的数据显示范围
    %set(gca,'XTick',[0:0.1:1.5]);%设置要显示坐标刻度
    %set(gca,'XTickLabel',[0:0.1:1.5]);%给坐标加标签 

    text(75,55,cell2mat(title(j_in)),'fontsize',14,'Fontname', 'Arial'); 
    %c = redblue(100);
    plot(china.long,china.lat,'color',[.5 .5 .5]);
    hold on
%   set(get(h,'Title'),'string','W/m^2','FontSize',14,'Fontname', 'Arial');
   set(gca,'FontSize',12,'Fontname', 'Arial'); 
    daspect([1,1,1]);
    
    
end


%path_MERRA1={'S:\final_project_17\data\ERAI\GWR_test_out\ERAI_GWR_2000_2014',...
path_MERRA1={'H:\final_project_25\data\CERES_Rs_clip\CERESRs_1du_2000_2017',...
             'H:\final_project_25\data\fixed_out\CERES_interplat_01\CERESRs_1du_2000_2017',...  
              'H:\final_project_25\data\fixed_out\AOD_CF_3067\AODCF3067_01du_2000_2017',...
              'H:\final_project_25\data\fixed_out\OLS_CF_only2\OLSCF_01du_2000_2017',...
              'H:\final_project_25\data\fixed_out\OLS_AOD_CF2\OLSAODCF_01du_2000_2017'...           
             }; 
timed={ 'H:\final_project_25\time_range.csv'};
   

title={'(b) CERES EBAF Rs1'...
       '(c) CERES EBAF Rs01'...
       '(d) GWR AOD and CF'...
       '(e) OLS CF'...
       '(f) OLS AOD and CF'...
       };

%figure;
%ha = tight_subplot(1,2,[.03 .03],[.07 .03],[.05 .05]);
%iindx=[2,3,4,5,6];
iindx=[2,3,4];
for idd1=1:length(path_MERRA1)

    timedx=importdata(cell2mat(timed(1)));
    yearmonth=timedx.data;
    
    if(idd1==2||idd1==3||idd1==1)
      llon1 = 66.7:0.5:136.7;
    else
      llon1 = 67:0.5:137;  
    end
%     if(idd1==3||idd1==4)
%       llon1 = 69.2:0.5:139.2;  
%     end   
    llat1 =15.5:0.5:55;
    [X,Y]=meshgrid(llon1,llat1);
    [image_MODIS,pc,tc]=freadenvi(cell2mat(path_MERRA1(idd1)));
   % [image_MERRA,pi,ti]=freadenvi(cell2mat(path_MERRA2(idd1)));

    [m_m,n_m,z_m]=size(image_MODIS);

    image_MODIS(image_MODIS==-9999)=NaN;
  %  image_MERRA(image_MERRA==-9999)=NaN;
   % image_MERRA(image_MERRA<0)=NaN;
    nanmean_MODIS=nanmean(image_MODIS(:,:,:),3);
  %  nanmean_MERRA=nanmean(image_MERRA(:,:,:),3);
    axes(ha(iindx(idd1)));
    domain = [70 160 10 60];

    plot(long,lat,'color',[.5 .5 .5]);
    hold on
%     plot(china.long,china.lat,'color',[.5 .5 .5]);
%     hold on
    Ysort=sort(Y(:,1),'descend');
    h=imagesc(X(1,:),Ysort,nanmean_MODIS');%其中C为包含有nan的数据
    set(h,'alphadata',~isnan(nanmean_MODIS')) 
    m=colorbar;



        plot(china.long,china.lat,'color',[.5 .5 .5]);
    hold on 
    %axis([70 150 10 60]);
    daspect([1,1,1]);

        caxis([100,200]);
    axis([105 115 24 35]);
       text(75,55,cell2mat(title(idd1)),'fontsize',14,'Fontname', 'Arial'); 
    hold on
    shpfile='H:\final_project_25\china.mat';
           dataAxesPosition = get(gca,'Position');
       xc = dataAxesPosition(1) + dataAxesPosition(3)*3/4;
       yc = dataAxesPosition(2) + dataAxesPosition(4)*4/5;
       loupeAxesPosition = [xc+.040, yc-.095, dataAxesPosition(3)*19/80*0.55, dataAxesPosition(4)*25/50*0.55]; 

       h2 = axes('Position',loupeAxesPosition);  
    % ax = h2;
    % ax.BoxStyle = 'full';
      longg1=china.long;
      latt1=china.lat;


        plot(longg1,latt1,'color',[.3 .3 .3],'LineWidth',1);

       axis([105 125 0 26]);
       set(h2,'xticklabel',['' '' '' ]);
       set(h2,'yticklabel',['' '' '' ]);
       box on
      set(h2,'TickLength',[0.025, 0.025])
    
    
    %set(get(h,'Title'),'string','W/m^2','FontSize',14,'Fontname', 'Arial');
    set(gca,'FontSize',14,'Fontname', 'Arial'); 
    daspect([1,1,1]);

end    
%    load('I:\MERRA_porject2\Fig\buleyellowred_colorbar.mat');
% colormap(seaice_2)
%        load('I:\MERRA_project\gis_template\nowithe.mat')
%     colormap(nowithe);

% [X, R] = geotiffread('I:\MERRA_project\data\AOD_observations\MODIS\MYD08_M3_tif_clip\DB_AOD_200301.tif');
% info = geotiffinfo('I:\MERRA_project\data\AOD_observations\MODIS\MYD08_M3_tif_clip\DB_AOD_200301.tif');
% geotiffwrite('I:\MERRA_project\data\AOD_observations\MODIS\exam_trend.tif',Z1,R, 'GeoKeyDirectoryTag', info.GeoTIFFTags.GeoKeyDirectoryTag);
 

% path_MERRA1={'G:\final_project_25\data\MODIS_cloud_clip\MODISCF_01du_2000_2017',...
%              'G:\final_project_25\data\AOD_clip\CERESAOD_01du_2000_2017',...
%              }; 
% timed={ 'G:\final_project_25\time_range.csv'};
%    
% 
% title={'(b)MODIS CF'...
%        '(c)CERES AOD'...
%        };
% 
% %figure;
% %ha = tight_subplot(1,2,[.03 .03],[.07 .03],[.05 .05]);
% iindx=[2,3,4,5,6];
% for idd1=1:length(path_MERRA1)
% 
%     timedx=importdata(cell2mat(timed(1)));
%     yearmonth=timedx.data;
%     
%     if(idd1==2||idd1==3||idd1==1)
%       llon1 = 66.7:0.5:136.7;
%     else
%       llon1 = 67:0.5:137;  
%     end
% %     if(idd1==3||idd1==4)
% %       llon1 = 69.2:0.5:139.2;  
% %     end   
%     llat1 =15.5:0.5:55;
%     [X,Y]=meshgrid(llon1,llat1);
%     [image_MODIS,pc,tc]=freadenvi(cell2mat(path_MERRA1(idd1)));
%    % [image_MERRA,pi,ti]=freadenvi(cell2mat(path_MERRA2(idd1)));
% 
%     [m_m,n_m,z_m]=size(image_MODIS);
% 
%     image_MODIS(image_MODIS==-9999)=NaN;
%   %  image_MERRA(image_MERRA==-9999)=NaN;
%    % image_MERRA(image_MERRA<0)=NaN;
%     nanmean_MODIS=nanmean(image_MODIS(:,:,:),3);
%   %  nanmean_MERRA=nanmean(image_MERRA(:,:,:),3);
%     axes(ha(idd1+6));
%     domain = [70 160 10 60];
% 
%     plot(long,lat,'color',[.5 .5 .5]);
%     hold on
% %     plot(china.long,china.lat,'color',[.5 .5 .5]);
% %     hold on
%     Ysort=sort(Y(:,1),'descend');
%     h=imagesc(X(1,:),Ysort,nanmean_MODIS');%其中C为包含有nan的数据
%     set(h,'alphadata',~isnan(nanmean_MODIS')) 
%     m=colorbar;
% 
%      caxis([0,1]);
% 
%         plot(china.long,china.lat,'color',[.5 .5 .5]);
%     hold on 
%     %axis([70 150 10 60]);
%     daspect([1,1,1]);
%     axis([70 150 10 60]);
%        text(75,55,cell2mat(title(idd1)),'fontsize',14,'Fontname', 'Arial'); 
%     hold on
%     shpfile='G:\final_project_25\china.mat';
%            dataAxesPosition = get(gca,'Position');
%        xc = dataAxesPosition(1) + dataAxesPosition(3)*3/4;
%        yc = dataAxesPosition(2) + dataAxesPosition(4)*4/5;
%        loupeAxesPosition = [xc+.040, yc-.095, dataAxesPosition(3)*19/80*0.55, dataAxesPosition(4)*25/50*0.55]; 
% 
%        h2 = axes('Position',loupeAxesPosition);  
%     % ax = h2;
%     % ax.BoxStyle = 'full';
%       longg1=china.long;
%       latt1=china.lat;
% 
% 
%         plot(longg1,latt1,'color',[.3 .3 .3],'LineWidth',1);
% 
%        axis([105 125 0 26]);
%        set(h2,'xticklabel',['' '' '' ]);
%        set(h2,'yticklabel',['' '' '' ]);
%        box on
%       set(h2,'TickLength',[0.025, 0.025])
%     
%     
%     %set(get(h,'Title'),'string','W/m^2','FontSize',14,'Fontname', 'Arial');
%     set(gca,'FontSize',14,'Fontname', 'Arial'); 
%     daspect([1,1,1]);
% 
% end   



