function U = centerU(data)
% input:
% data: processed readBox.m data folder

% output:
% U:    time-averaged streamwise centerline velocity

u = data(:,:,51,1);
U = mean(u,1);

% save data
tic
disp('saving normalized radius matrix...')
filename = 'centerU';
out_dir = fullfile('..','output_data');
save(fullfile(out_dir, filename),'U','-v7.3');
disp(['done! saved as ', filename, '.mat! ♪(´▽｀)'])
toc

% 
% % volumetric data coordinate definition
% nx = 300;
% output = zeros(nx,1,1,nmat);
% 
% % loop over saved matrices
% for i = 1:nmat
% 
%     % extract data
%     currMat = load(fullfile(folder,mat(i).name));
%     data = currMat.data;
%     U = data(:,:,51,1);
% 
%     % find time-averaged velocities
%     outputMean = mean(U,1);
% 
%     % add to resultant vector
%     output(:,:,:,i) = outputMean;
% 
% end
% 
% % finish averaging velocities over entire dataset and return
% U = mean(output,4);

end

