function re = normTensor(tensor,U)
% input:
% tensor:   Reynolds Stress tensor without normalization
% U:    time-averaged streamwise centerline velocity

% output:
% result:   normalized Reynolds Stress tensor

% create normalization
norm = U.^2;

% normalize tensor
re = tensor ./ norm;

% save normalized tensor
tic
disp('saving normalized tensor...')
filename = 'normRe';
out_dir = fullfile('..','matrices','norm_tensors');
save(fullfile(out_dir,filename),'re','-v7.3');
disp(['done! saved as ', filename, '.mat! ♪(´▽｀)'])
toc

end