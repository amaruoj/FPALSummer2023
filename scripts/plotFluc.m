function plotFluc(val1,val2,input)
% input:
% val1, val2:   variables to be averaged
% input:    combined fluctuation

% output:
% figure describing the combined fluctuation, based on other figure
% plotting stuff but kept apart from the stress generating function to keep
% things cleaner

% save plots
plotVar = permute(input(1,:,:),[2,3,1]);
fig = contourf(plotVar,'EdgeColor','none');
colorbar;
num = append(num2str(val1),num2str(val2));
if num == '11'; name = 'UU'; end
if num == '12'; name = 'UV'; end
if num == '22'; name = 'VV'; end
if num == '33'; name = 'WW'; end
title(['Combined Fluctuation for the ',name,' Component of the Tensor']);
xlabel("Y/D_e, Y-Distance from Nozzle Exit");
ylabel("X/D_e, X-Distance from Nozzle Exit");
view(90,90);
figName = append('fluctcontour_',num,'.fig');
pngName = append('fluctcontour_',num,'.png');
out_dir = fullfile('..','figs');
saveas(gcf,fullfile(out_dir,figName));
saveas(gcf,fullfile(out_dir,pngName));
disp('done! saved as data_contour.fig AND .png! ♪(´▽｀)')

end

