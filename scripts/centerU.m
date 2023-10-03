function U = centerU(folder)
% input:
% data: processed readBox.m data folder

% output:
% U:    time-averaged streamwise centerline velocity

% data retrieval
mat = dir(fullfile('..','output_data','*.mat'));
nmat = length(mat);

% volumetric data coordinate definition
nx = 300;
output = zeros(nx,1,1,nmat);

% loop over saved matrices
for i = 1:nmat
    
    % extract data
    currMat = load(fullfile(folder,mat(i).name));
    data = currMat.data;
    U = data(:,:,51,1);
    
    % find time-averaged velocities
    outputMean = mean(U,1);

    % add to resultant vector
    output(:,:,:,i) = outputMean;
    
end

% finish averaging velocities over entire dataset and return
U = mean(output,4);

end

