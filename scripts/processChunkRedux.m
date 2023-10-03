function processChunkRedux(folder)
% input:
% folder:   directory to the folder containing the .pbin and .pcd files

% output:
% saved big data matrix
% meant for processing data and saving it without having to use readBox.m
% every time we sift through the data

% prep data once so we don't need to parse every time
% cd(folder)
pbinPath = append(folder,'/*.pbin');
pcdPath = append(folder,'/*.pcd');
pbin = dir(pbinPath);
pcd = dir(pcdPath);
% cd('/home/amaru/Documents/amaru_data/vm_scripts2')

% volumetric data coordinate definition
nx = 751;
ntheta = 128;
nr = 151;

% actual values for reference:
% x = linspace(0,30,nx);
% theta = linspace(0, 2*pi-2*pi/128,ntheta);
% r = linspace(0,6,nr);

% creates output matrix of size nfiles x ncoords x nvars
nfiles = length(pcd);
chunk = 5;
nchunk = nfiles / chunk;
ncoords = nx * ntheta * nr;
nvars = 5;

% data processing loop
tic
for j = 1:nchunk+1
    disp(['There are ', num2str(nchunk - j + 1), ' chunks left to process!'])
    vol_data = zeros(chunk,ncoords,nvars);
%     cd(folder);
    for i = 1:chunk
        flag = 0;
        toGo = nfiles - (j-1) * chunk - i;
        if toGo == -1  % in case the chunk division is off
            flag = 1;
            break
        end
        
        disp(['There are ', num2str(chunk - i + 1), ' files left to process in this chunk!'])
        
        % use readBox.m
%         cd('/home/amaru/Documents/amaru_data/vm_scripts2')
        currPcd = pcd(chunk*j-chunk+i);
        [~, data] = readBox(fullfile(folder, pbin.name),fullfile(folder, currPcd.name));
%         [~, data] = readBox(pbin.name,currPcd.name);
        data = data';
        
        % update raw data matrix
        vol_data(i,:,(1:5)) = data;
        
        % clear space
        clear data;
        
    end
    
    if flag == 1
        break
    end
    
    % reshaping data
    tic
    disp('reshaping data to make it easier to work with...')
    vol_data_reshape = zeros(ntheta, nr, nx, 5, chunk);
    for k = 1:5
        for l = 1:chunk
            vol_data_reshape(:,:,:,k,l) = reshape(vol_data(l,:,k), ntheta, nr, nx);
        end
    end
    disp('finished! (*¯︶¯*)')
    toc
    
    data = vol_data_reshape;
    
    % save data
    
    % GW: define the out_dir here and pass it to save()
    out_dir = fullfile('..','output_data');
    save(fullfile(out_dir, filename),'data','-v7.3');
    
    tic
    disp('saving data...')
    cd('/home/amaru/Documents/amaru_data/output_data') % vm path
%     cd('/Users/amaru/Desktop/FPAL_REU/project_2/vm_scripts2/output_data')   % local path
    filename = append('output_',num2str(j));
    save(filename,'data','-v7.3');
    disp(['done! saved as ', filename, '.mat! ♪(´▽｀)'])
    clear data;
    toc
    
end
disp('all done! (>^ω^<)')
toc

end