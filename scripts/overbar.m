function [mean1,mean2] = overbar(folder,val1,val2)
% input:
% data: readBox.m data folder
% val1, val2:   variables to be averaged

% output:
% mean1: vector of means for variable 1 at each location from the data
% mean2: vector of means for variable 1 at each location from the data

% data retrieval
mat = dir(fullfile(folder,'*.mat'));
nmat = length(mat);

% planar data coordinate definition
nx = 300;
ny = 101;
% nz = 1;
output = zeros(nx,ny,nmat,2);

% loop over saved matrices
for i = 1:nmat
    
    % extract data
    currMat = load(fullfile(folder,mat(i).name));
    data = currMat.data;
    U1 = data(:,:,:,val1); U2 = data(:,:,:,val2);
    
    % find time-averaged velocities
    outputMean1 = mean(U1,1); outputMean2 = mean(U2,1);
    outputMean1 = permute(outputMean1,[2,3,1]);
    outputMean2 = permute(outputMean2,[2,3,1]);

    % add to resultant vector
    output(:,:,i,1) = outputMean1; output(:,:,i,2) = outputMean2;
    
end

% finish averaging velocities over entire dataset and return
mean1 = mean(output(:,:,:,1),3); mean2 = mean(output(:,:,:,2),3);

if val1 == 1
    uBar = mean1;
    filename = 'uBar';
    out_dir = fullfile('..','matrices','mean_data');
    save(fullfile(out_dir,filename),'uBar','-v7.3');
end

end

