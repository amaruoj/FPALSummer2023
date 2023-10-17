function re = normTensor(folder)
% input:
% folder: path to outputs

% output:
% result:   normalized Reynolds Stress tensor

% load data
raw_re = load(fullfile(folder,'raw_re.mat')).tensor;
U = load(fullfile(folder,'centerU.mat')).U;

% create normalization
norm = U'.^2;

% normalize tensor
re = raw_re ./ norm;

% save normalized tensor
tic
disp('saving normalized tensor...')
filename = 'normRe';
out_dir = fullfile('..','output_data');
save(fullfile(out_dir,filename),'re','-v7.3');
disp(['done! saved as ', filename, '.mat! ♪(´▽｀)'])
toc

end