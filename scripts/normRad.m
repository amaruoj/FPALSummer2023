function radius = normRad(folder)
% input:
% data: readBox.m data folder

% output:
% radius:   normalized radius, r/r_1/2

% load data
data = load(fullfile(folder,'output.mat')).data;
meanU = load(fullfile(folder,'uBar.mat')).uBar;

% calculate centerline velocity
U = centerU(data);

% planar data coordinate definition
nx = 300;
% ny = 101;
% nz = 1;
r = linspace(0,5,51);
halves = zeros(nx,1);
radius = zeros(nx,1);

% radius normalization loop
tic
disp('normalizing radius...')
for i = 1:nx
    disp([num2str(nx - i + 1), ' xvals left!'])
    if i <= 70; type = 'gauss2';
    else; type = 'poly3'; end
    halfU = U(i,:,:) / 2;
    u = meanU(i,:,:)';
    u = u(:,51:end);
    f = fit(r,u,type);
    [~,b] = min(abs(f(u)-halfU));
    halfR = f(r(b));
    halves(i) = halfR;
    radius(i) = r(i) / halfR;
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

% analyzing the validity of the fit


