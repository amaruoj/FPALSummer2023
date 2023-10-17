function radius = normRad(folder)
% input:
% data: readBox.m data folder

% output:
% radius:   normalized radius, r/r_1/2

% load data
data = load(fullfile(folder,'output.mat')).data;
meanU = load(fullfile(folder,'uBar.mat')).uBar;

% calculate centerline velocity
U = centerU(data)';

% planar data coordinate definition
nx = 300;
% ny = 101;
% nz = 1;
nr = 51;
r = linspace(0,5,nr)';
% halves = zeros(nx);
halfRs = zeros(nx,1);
halfUs = zeros(nx,1);
radius = zeros(nx,nr);

% radius normalization loop
tic
disp('normalizing radius...')
for i = 1:nx
    disp([num2str(nx - i + 1), ' xvals left!'])
    if i <= 70; type = 'gauss2';
    else; type = 'poly3'; end
    halfU = U(i,:,:) / 2;
    u = meanU(i,:,:);
    u = u(:,51:end)';
    f = fit(r,u,type);
    % [~,b] = min(abs(f(u)-halfU));
    % halfR = f(r(b));
    fun = @(r) halfU - f(r);
    halfR = fzero(fun,[0 5]);
    halfU = f(halfR);
    halfRs(i,:) = halfR;
    halfUs(i,:) = halfU;
    radius(i,:) = r ./ halfR;
end
disp('finished normalizing!')
toc

% save result
tic
disp('saving normalized radius matrix...')
filename = 'normR';
out_dir = fullfile('..','output_data');
save(fullfile(out_dir, filename),'radius','-v7.3');
disp(['done! saved as ', filename, '.mat! ♪(´▽｀)'])
toc

% analyzing the validity of the fit with plots
fig1 = plot(halfRs,'o');
title("Jet Half-Width versus X-Distance")
xlabel("X/D_e") 
ylabel("r_{1/2}")

figure
fig2 = plot(U,"Color","red");
hold on
plot(U./2,"color","green")
plot(halfUs,"--","Color","magenta")
title("Jet Velocity Fit Test")
xlabel("X/D_e")
ylabel("Jet Velocity")
legend("U","true U_{1/2}","fitted U_{1/2}")

% save plots
disp('saving plots...')
figName1 = "fit_test_r.fig";
pngName1 = "fit_test_r.png";
figName2 = "fit_test_u.fig";
pngName2 = "fit_test_u.fig";
out_dir = fullfile('..','figs');
saveas(fig1,fullfile(out_dir,figName1));
saveas(fig1,fullfile(out_dir,pngName1));
saveas(fig2,fullfile(out_dir,figName2));
saveas(fig2,fullfile(out_dir,pngName2));
disp('done!')

