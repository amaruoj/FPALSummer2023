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
% x = linspace(0.1,30,300);
% y = linspace(-5,5,101);
% z = 0;

% creates output matrix of size nfiles x ncoords x nvars
nfiles = length(pcd);
ncoords = nx * ny;
nvars = 5;

% process one file to find idx x < 0 to trim data
[coords, ~] = readBox(fullfile(folder, pbin.name),fullfile(folder, pcd(1).name));
ind = find(coords(:,1,1)>0);
planar_data = zeros(nfiles,ncoords,nvars);
clear coords

% data processing loop
tic

for i = 1:nfiles
    disp(['There are ', num2str(nfiles - i + 1), ' files left to process!'])
    
    % use readBox.m
    currPcd = pcd(i);
    [~, data] = readBox(fullfile(folder, pbin.name),fullfile(folder, currPcd.name));
    data = data';
    data = data(ind,:); %#ok<FNDSB>
    
    % update raw data matrix
    planar_data(i,:,(1:5)) = data;
    
    % clear space
    clear data;
end

% reshaping data
tic
disp('reshaping data to make it easier to work with...')
%     planar_data_reshape = reshape(planar_data, nx, ny, nz, [], chunk);
planar_data_reshape = reshape(planar_data,chunk,nx,ny,[]);
disp('finished! (*¯︶¯*)')
toc

data = planar_data_reshape;

% save data
tic
disp('saving data...')
filename = 'output';
out_dir = fullfile('..','output_data');
save(fullfile(out_dir, filename),'data','-v7.3');
disp(['done! saved as ', filename, '.mat! ♪(´▽｀)'])
clear data;
toc

disp('all done! (>^ω^<)')
toc

end