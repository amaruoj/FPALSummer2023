function radius = normRadius(folder)
% input:
% data: readBox.m data folder

% output:
% radius:   normalized radius, r/r_1/2

% calculate centerline velocity
U = centerU(folder);

% planar data coordinate definition
nx = 300;
ny = 101;
nz = 1;
r = linspace(-5,5,ny)';
idx1 = find(r >= 0); idx2 = find(r <= 0);
r1 = r(idx1); r2 = r(idx2); r2 = flip(abs(r2));
y = 51;
radius = zeros(nx,y);
meanU = load(fullfile('..','matrices','mean_data','uBar.mat')).uBar;
halves = zeros(nx,1);

% find the r_1/2 for each xval
tic
disp('normalizing radius...')
for i = 1:nx
    disp([num2str(nx - i + 1), ' xvals left!'])
    % find the best r_1/2 for each theta
    halfRs = zeros(nz,1);
    if i <= 70
        type = 'gauss2';
    else
        type = 'poly3';
    end
    for j = 1:nz
        halfU = U(i,:,:) / 2;
        u = meanU(i,:,j,:)';
        u1 = u(idx1); u2 = flip(u(idx2));
%         f1 = fit(r1,u1,f);
%         f2 = fit(r2,u2,f);
%         [~,b1] = min(abs(f1(u1)-halfU));
%         [~,b2] = min(abs(f1(u1)-halfU));
%         halfR1 = f1(r1(b1)); halfR2 = f2(r2(b2));
%         halfRs(j) = mean([halfR1,halfR2]);
        f = fit(r1,u1,type);
        [~,b] = min(abs(f(u)-halfU));
        halfR = f(r(b));
        halfRs(j) = halfR;
    end
    halfR = mean(halfRs);
    halves(i) = halfR;
    radius(i,:) = r1 ./ halfR;
end
radius = abs(radius);

disp('finished normalizing!')
toc

currU = meanU(200,51:end)';
realHalf = currU ./2;
% plot(r1,halfU,'blue')
% hold on
% plot(r1,realHalf,'magenta')


% save result
tic
disp('saving normalized radius matrix...')
filename = 'normR';
out_dir = fullfile('..','matrices','radius');
save(fullfile(out_dir, filename),'radius','-v7.3');
disp(['done! saved as ', filename, '.mat! ♪(´▽｀)'])
toc

end
