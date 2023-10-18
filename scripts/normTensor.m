function re = normTensor(folder)
% input:
% folder: path to outputs

% output:
% result:   normalized Reynolds Stress tensor

% load data
temp = load(fullfile(folder,'raw_re.mat'));
raw_re = temp.tensor;
temp = load(fullfile(folder,'centerU.mat'));
U = temp.U;

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