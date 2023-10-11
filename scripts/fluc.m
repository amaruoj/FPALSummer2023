function [fluc1,fluc2] = fluc(data,mean1,mean2,val1,val2)
% input:
% data: readBox.m data folder
% mean1, mean2: time-averaged velocity profiles
% val1, val2:   names of stress variables to pull raw data

% output:
% fluc1, fluc2: velocity fluctuations at every (t,x,y)

% restructure data
mean1 = permute(mean1,[3,1,2]); mean2 = permute(mean2,[3,1,2]);

% calculate fluctuation
U1 = data(:,:,:,val1); U2 = data(:,:,:,val2);
fluc1 = abs(U1 - mean1); fluc2 = abs(U2 - mean2);

% save plots
plotVar = permute(fluc1(1,:,:),[2,3,1]);
fig = contourf(plotVar,'EdgeColor','none');
colorbar;
num = num2str(val1);
if num == '1'; name = 'U'; end
if num == '2'; name = 'V'; end
if num == '3'; name = 'W'; end
title(['Fluctuation Contour for the ',name,' Component of the Velocity at 1 Acoustic Time Unit']);
xlabel("Y/D_e, Y-Distance from Nozzle Exit");
ylabel("X/D_e, X-Distance from Nozzle Exit");
view(90,90);
figName = append('fluccontour_',num,'.fig');
pngName = append('fluccontour_',num,'.png');
out_dir = fullfile('..','figs');
saveas(gcf,fullfile(out_dir,figName));
saveas(gcf,fullfile(out_dir,pngName));
disp('done! saved as data_contour.fig AND .png! ♪(´▽｀)')



end

