function processData(folder)
% input:
% folder:   directory to the folder containing the .pbin and .pcd files

% output:
% saved big data matrix
% meant for processing data and saving it without having to use readBox.m
% every time we sift through the data

% prep data once so we don't need to parse every time
pbin = dir(fullfile(folder,'*.pbin'));
pcd = dir(fullfile(folder,'*.pcd'));

% planar data coordinate definition
nx = 300;
ny = 101;
% nz = 1;

% actual values for reference:
% x = linspace(-10,30,401));
% x = linspace(0.1,30,300); is the actual x-vector
% y = linspace(-5,5,101);
% z = 0;

% creates output matrix of size nt x ncoords x nvars
nt = length(pcd);
ncoords = nx * ny;
nvars = 5;

% process one file to find idx x < 0 to trim data
[coords, ~] = readBox(fullfile(folder, pbin.name),fullfile(folder, pcd(1).name));
ind = find(coords(:,1,1)>0);
planar_data = zeros(nt,ncoords,nvars);

% data processing loop
tic

for i = 1:nt
    
    disp(['There are ', num2str(nt - i + 1), ' files left to process!'])
    
    % use readBox.m
    currPcd = pcd(i);
    [~, data] = readBox(fullfile(folder, pbin.name),fullfile(folder, currPcd.name));
    data = data';
    data = data(ind,:);
    
    % update raw data matrix
    planar_data(i,:,(1:5)) = data;
    
    % clear space
    clear data;
end

% reshaping data
tic
disp('reshaping data to make it easier to work with...')
planar_data_reshape = reshape(planar_data,nt,nx,ny,[]);
disp('finished! (*¯︶¯*)')
toc

data = planar_data_reshape;

% save data
tic
disp('saving data...')
filename = 'output';
out_dir = fullfile('..','output_data');

if ~exist(out_dir,'dir')
   mkdir(out_dir); 
end

save(fullfile(out_dir, filename),'data','-v7.3');
disp(['done! saved as ', filename, '.mat! ♪(´▽｀)'])
toc

disp('all done! (>^ω^<) returning contour plot of velocity')
toc

X = reshape(coords(ind,1), nx, ny);
Y = reshape(coords(ind,2), nx, ny);
fig = contourf(X,Y, squeeze(data(2,:,:,5)),'edgecolor','none');
title("Contour Plot showing Density");
xlabel("X/D_e, X-Distance from Nozzle Exit");
ylabel("Y/D_e, Y-Distance from Nozzle Exit");
colorbar;
clear data coords

% save contour plot

disp('saving plot...')
figName = 'data_contour.fig';
pngName = 'data_contour.png';
out_dir = fullfile('..','figs');

if ~exist(out_dir,'dir')
   mkdir(out_dir); 
end

saveas(gcf,fullfile(out_dir,figName));
saveas(gcf,fullfile(out_dir,pngName));
disp('done! saved as data_contour.fig AND .png! ♪(´▽｀)')
clear data;

end