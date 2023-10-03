function fluc(folder,mean1,mean2,val1,val2)
% input:
% data: readBox.m data folder
% mean1, mean2: time-averaged velocity profiles
% val1, val2:   names of stress variables to pull raw data

% output:
% fluc1, fluc2: velocity fluctuations at every (x,r,theta,t), saved in the
% same chunks/chunk sizes as the raw data

% data retrieval
mat = dir(fullfile(folder,'*.mat'));
nmat = length(mat);

% restructure data
mean1 = permute(mean1,[3,1,2]); mean2 = permute(mean2,[3,1,2]);

% loop over saved matrices
for i = 1:nmat
    
    % extract data
    currMat = load(fullfile(folder,mat(i).name));
    data = currMat.data;
    U1 = data(:,:,:,val1); U2 = data(:,:,:,val2);

    % find fluctuations
    fluc1 = abs(U1 - mean1); fluc2 = abs(U2 - mean2);
    
    % save resultant matrix
    filename = append('fluc1_',num2str(i));
    out_dir = fullfile('..','matrices','flucs');
    save(fullfile(out_dir,filename),'fluc1','-v7.3');
    filename = append('fluc2_',num2str(i));
    save(fullfile(out_dir,filename),'fluc2','-v7.3');

end

end

