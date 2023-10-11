function [mean1,mean2] = overbar(data,val1,val2)
% input:
% data: readBox.m data folder
% val1, val2:   variables to be averaged

% output:
% mean1: vector of means for variable 1 at each location from the data
% mean2: vector of means for variable 1 at each location from the data

% averaging
U1 = data(:,:,:,val1); U2 = data(:,:,:,val2);
mean1 = mean(U1,1); mean2 = mean(U2,1);
mean1 = permute(mean1,[2,3,1]); mean2 = permute(mean2,[2,3,1]);

if val1 == 1
    uBar = mean1;
    filename = 'uBar';
    out_dir = fullfile('..','output_data');
    save(fullfile(out_dir,filename),'uBar','-v7.3');
end

% save plots
fig = contourf(mean1,'EdgeColor','none');
colorbar;
num = num2str(val1);
if num == '1'; name = 'U'; end
if num == '2'; name = 'V'; end
if num == '3'; name = 'W'; end
title(['Mean Velocity Contour for the ',name,' Component of the Velocity']);
xlabel("Y/D_e, Y-Distance from Nozzle Exit");
ylabel("X/D_e, X-Distance from Nozzle Exit");
view(90,90);
figName = append('meancontour_',num,'.fig');
pngName = append('meancontour_',num,'.png');
out_dir = fullfile('..','figs');
saveas(gcf,fullfile(out_dir,figName));
saveas(gcf,fullfile(out_dir,pngName));
disp('done! saved as data_contour.fig AND .png! ♪(´▽｀)')

end

