function plotStress(stress,val1,val2)
% input:
% stress:   calculated component of the stress tensor

% output:
% figure describing the contour of the stress tensor

% save plots
fig = contourf(stress,'EdgeColor','none');
colorbar;
num = append(num2str(val1),num2str(val2));
if num == '11'; name = 'UU'; end
if num == '12'; name = 'UV'; end
if num == '22'; name = 'VV'; end
if num == '33'; name = 'WW'; end
title([name,' Component of the Stress Tensor (no normalization)']);
xlabel("Y/D_e, Y-Distance from Nozzle Exit");
ylabel("X/D_e, X-Distance from Nozzle Exit");
view(90,90);
figName = append('stresscontour_',num,'.fig');
pngName = append('stresscontour_',num,'.png');
out_dir = fullfile('..','figs');
saveas(gcf,fullfile(out_dir,figName));
saveas(gcf,fullfile(out_dir,pngName));
disp(['done! saved as ',figName,' AND .png! ♪(´▽｀)'])

end

