%Script analyses data from phase shifting in controlled swap experiment"

clear all
clc

%Open dialog box
[filename, pathname] = uigetfile({'*.xls';'*.xlsx';},'File Selector');

%Write to variable

[~, ~, raw] = xlsread([pathname filename],'B2:B999');
data_pm_1 =  reshape([raw{:}],size(raw));
data_pm_1 = data_pm_1(~isnan(data_pm_1));

%Open dialog box 2
[filename, pathname] = uigetfile({'*.xls';'*.xlsx';},'File Selector');

%Write to variable
[~, ~, raw] = xlsread([pathname filename],'B2:B999');
data_pm_2 =  reshape([raw{:}],size(raw));
data_pm_2 = data_pm_2(~isnan(data_pm_2));

%% Preparedata
%point each range (star and end) of phase shift, starting from 0:pi/4:2pi

%First PM loop
pm_1=[]
for i=1:1:8
    figure()
    plot(data_pm_1);
    ylim([1 3]);
    [col,~] = ginput(2)
    col=round(col);
    data_pm_1_cell{i}=medfilt1(data_pm_1(col(1):col(2)),2); %median filtering
    close()
    pm_1_mean_value(i)=mean(data_pm_1_cell{i}); %mean intensity value of phase shift
    pm_1=[pm_1; data_pm_1_cell{i}] %joining data
end

%Save variables
save([pathname 'PM_1_mean_values.mat'],'pm_1_mean_value')
save([pathname 'PM_1.mat'],'pm_1')


%Second PM loop
pm_2=[]
for i=1:1:8
    figure()
    plot(data_pm_2);
    ylim([1 3]);
    [col,~] = ginput(2)
    col=round(col);
    data_pm_2_cell{i}=medfilt1(data_pm_2(col(1):col(2)),2);  %median filtering
    close()
    pm_2_mean_value(i)=mean(data_pm_2_cell{i}); %mean intensity value of phase shift
    pm_2=[pm_2; data_pm_2_cell{i}] %joining data
end

%Save variables
save([pathname 'PM_2_mean_values.mat'],'pm_2_mean_value')
save([pathname 'PM_2.mat'],'pm_2')

figure()
plot(pm_1,'ok','MarkerSize',2.0,'MarkerFaceColor','k')
hold on
plot(pm_2,'ob','MarkerSize',2.0,'MarkerFaceColor','b')
ylabel('Power [microW]')
xlabel('Range [au]')
ylim([1 2.5]);
legend('Power meter 1', 'Power meter 2')
set(gcf,'color','w')

saveas(gcf,[pathname 'Comparison.png'])

%%Gamma
gamma=(pm_1_mean_value-pm_2_mean_value)./(pm_1_mean_value+pm_2_mean_value);
save([pathname 'gamma.mat'],'gamma')


