clear all


% a=[1 2 3 4 5 6 7 8 9 10];
% save('var.mat','a');     %将变量a保存在var.mat文件中
% 
% %下面是调用
% b=load('var.mat','a');   %将var.mat中的变量a读取出，放在b中

load('G:\final_project_25\data\Sundu_Derived_Rs2017.mat')

filein='F:\final_project_17\data\China_Rs_MERRA12.nc';
miantitle={'Surface Solar Radiation'};

llon = station(:,2);
llat = station(:,3);
year = date_monthly(:,1);
month1 = date_monthly(:,2);
Rs_ob1 = SD_monthly;

Rs_ob=Rs_ob1(591:end,:)';
month=month1(591:end,:)';

Rs_MERRA=Rs_ob(:,:);
%month=month1(243:end);
title={'(a) Observation Rs'};
[m,n]=size(Rs_MERRA);
anomy_data=zeros(m,n,1);
for ji=1:m
    for i=1:12
        t=find(month==i);
        anomy_data(ji,t,1)=Rs_MERRA(ji,t)-nanmean(Rs_MERRA(ji,t));
    end
end
 xx=1:1:n;
 xx=xx';
 inx=[ones(length(xx),1),xx];
 anomy_trend=zeros(2,m,3);
 anomy_trend(:,:,:)=NaN;
for i=1:m
   for iin=1:1
      n11=find(~isnan(anomy_data(i,:,iin))); 
      inxx=inx(n11,:);
      [b,bint,r,rint,stats]=regress(anomy_data(i,n11,iin)',inxx);
      %[b,bint,r,rint,stats]=regress(Rs_M1(i,n11)',inxx);
      anomy_trend(1,i,iin)=b(2);
      anomy_trend(2,i,iin)=stats(3);
   end
end
figure;
%set (gcf,'Position',[500,500,800,800], 'color','w');
%scrsz = get(0,'ScreenSize');
%figure('Position',[5 scrsz(4)/2 scrsz(3) scrsz(4)/2]);
ha = tight_subplot(2,2,[.05 .05],[.07 .07],[.07 .07]);
shpfile='G:\final_project_25\china.mat';
axes(ha(1));
domainx=[70 150 10 60];
dilim=1;
scax=1;
scay=4;
ybarheight=150;
%mean_data=anomy_trend(:,:,idd1);
%region_trend_draw_hist(ha(idd1+4),llon,llat,dilim,domainx,shpfile,mean_data,[-20,20],title(idd1),scax,scay,ybarheight);
region_trend_draw(llon,llat,dilim,domainx,shpfile,anomy_trend,[-20,20],title(1),1)

%------------------------------------------------------------------------------------
%------------------------------------------------------------------------------------
%------------------------------------------------------------------------------------
 %'S:\final_project_17\data\ERAI\GWR_test_out\ERAI_ori_2000_2014_trend.mat'...
%  trendfiles={'H:\final_project_17\data\ERAI\GWR_test_out\modis_clouds_2000_2014_trend.mat',...
%              'H:\final_project_17\data\ERAI\GWR_test_out\CERES_1du_2000_2014_trend.mat',...
%              'H:\final_project_23\data\fixed_out\AOD_CF\anomGWRCF67_01du_2000_2014_trend.mat'...
%              }; 
%   trendfiles={'H:\final_project_17\data\ERAI\GWR_test_out\modis_clouds_2000_2014_trend.mat',...
%              'H:\final_project_23\data\fixed_out\AOD_CF\anomGWRAODCF67_01du_2000_2014_trend.mat',...
%              'H:\final_project_23\data\fixed_out\AOD_CF\anomGWRCF67_01du_2000_2014_trend.mat'...
%              }; 
%  trendfiles={'H:\final_project_17\data\ERAI\GWR_test_out\modis_clouds_2000_2014_trend.mat',...
%             'H:\final_project_17\data\ERAI\GWR_test_out\CERES_1du_2000_2014_trend.mat',...
%            'H:\final_project_23\data\fixed_out_OLS\batch_out_CF\OLSCF_01du_2000_2014_trend.mat',...
%              }; 
%  trendfiles={'G:\final_project_25\data\CERES_Rs_clip\CERESRs_1du_2000_2017_trend.mat'...
%              'G:\final_project_25\data\fixed_out\CF_only_3067\CF3067_01du_2000_2017_trend.mat',...  
%              'G:\final_project_25\data\fixed_out\AOD_CF_3067\AODCF3067_01du_2000_2017_trend.mat',...
%               'G:\final_project_25\data\fixed_out\OLS_CF_only2\OLSCF_01du_2000_2017_trend.mat',... 
%              'G:\final_project_25\data\fixed_out\OLS_AOD_CF2\OLSAODCF_01du_2000_2017_trend.mat'...   
%              }; 
         
  trendfiles={'G:\final_project_25\data\CERES_Rs_clip\CERESRs_1du_2000_2017_trend.mat'...
             'G:\final_project_25\data\fixed_out\CF_only_3067\CF3067_01du_2000_2017_trend.mat',...  
             'G:\final_project_25\data\fixed_out\AOD_CF_3067\AODCF3067_01du_2000_2017_trend.mat'...
             };         
%path_MERRA2='I:\final_project\data\reanalyses\raw_data\MERRA2_china_1980_2014_OI_L';
%'I:\final_project_2\data\MERRA2\reanalyses_irtate\clip\MERRA2_198001_201412_irtate'...
timed={ 'G:\final_project_25\time_range.csv'};
title={'(b) Satellite derived Rs','(c) GWR CF Rs','(d) GWR CF AOD Rs','(e) OLS CF AOD Rs','(d)OLS CF AOD Rs'};
%timeperiod=[255,531,255,507,591,255,591,243;384,660,384,636,720,384,720,372];%卫星比较

% figure;
% ha = tight_subplot(1,2,[.03 .03],[.07 .03],[.05 .05]);
iindx=[1,2];
llon1 = 67:1:137;
llat1 =15.5:1:55;
[X,Y]=meshgrid(llon1,llat1);
for idd1=1:length(trendfiles)
    load(cell2mat(trendfiles(idd1))); 
    axes(ha(idd1+1));
    shpfile='G:\MERRA_project\china.mat';
    domainx=[70 150 10 60];
    dilim=1;
    scax=1;
    scay=4;
    ybarheight=150;
    mean_data=anomy_trend_MODIS;
   % region_trend_draw_image_hist(ha(data_i),llon1,llat1,dilim,domainx,shpfile,mean_data,[-8,8],title(data_i),scax,scay,ybarheight);
%     if(idd1==1)
%     region_trend_draw_image_smap(llon1,llat1,dilim,domainx,shpfile,mean_data,[-0.2,0.2],title(idd1),1,50)
%     else
        if(idd1==1)
            region_trend_draw_image_smap(llon1,llat1,dilim,domainx,shpfile,mean_data,[-20,20],title(idd1),1,1)   
        else
            region_trend_draw_image_smap(llon1,llat1,dilim,domainx,shpfile,mean_data,[-20,20],title(idd1),1,80)
%             if(idd1==7)
%                   region_trend_draw_image_smap(llon1,llat1,dilim,domainx,shpfile,mean_data,[-0.2,0.2],title(idd1),1,300)    
%             else
%                 if(idd1==6)
%                    region_trend_draw_image_smap(llon1,llat1,dilim,domainx,shpfile,mean_data,[-0.2,0.2],title(idd1),1,80)
%                 else
%                    region_trend_draw_image_smap(llon1,llat1,dilim,domainx,shpfile,mean_data,[-20,20],title(idd1),1,80)  
%                 end
%              end
        end
          

    end

load('G:\MERRA_porject2\Fig\buleyellowred_colorbar.mat');
colormap(seaice_2)
%        load('I:\MERRA_project\gis_template\nowithe.mat')
%     colormap(nowithe);

% [X, R] = geotiffread('I:\MERRA_project\data\AOD_observations\MODIS\MYD08_M3_tif_clip\DB_AOD_200301.tif');
% info = geotiffinfo('I:\MERRA_project\data\AOD_observations\MODIS\MYD08_M3_tif_clip\DB_AOD_200301.tif');
% geotiffwrite('I:\MERRA_project\data\AOD_observations\MODIS\exam_trend.tif',Z1,R, 'GeoKeyDirectoryTag', info.GeoTIFFTags.GeoKeyDirectoryTag);