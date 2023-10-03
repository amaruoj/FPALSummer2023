function result = meanFluc(folder)
% input:
% folder:   folder containing combined fluctuation files

% output:
% result: complete & finalized stress tensor

% data retrieval
mat = dir(fullfile(folder,'*.mat'));
nmat = length(mat);

% planar data coordinate definition
nx = 300;
ny = 101;
% nz = 1;
output = zeros(nx,ny,nmat);

% loop over saved matrices
for i = 1:nmat
    
    % extract data
    currMat = load(fullfile(folder,mat(i).name));
    data = currMat.fluc12;
    
    % find time-averaged velocities
    currMean = mean(data,1);
    currMean = permute(currMean,[2,3,1]);

    % add to resultant vector
    output(:,:,i) = currMean;
    
end

% finish averaging velocities over entire dataset and return
result = mean(output,3);

end

