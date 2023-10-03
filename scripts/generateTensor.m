function tensor = generateTensor(folder)
% input:
% folder:   folder of data processed through readBox.m and processData.m,
% formatted as a matrix of shape nthetas x nr x nx x nvars x nfiles

% output:
% result:   Reynolds Stress Tensor without normalization

names = {'uu','uv','vv','ww'};

% planar data coordinate definition
nx = 300;
ny = 101;
% nz = 1;

% initialize tensor
tensor = zeros(nx,ny,4);

tic
disp('generating tensor...')
for i = 1:length(names)
    tic
    disp(['building the ', names{i}, ' component of the tensor!'])
    tensor(:,:,i) = generateStress(folder,names{i});
    toc
end
disp('tensor generated!')
toc

% save data
tic
disp('saving tensor...')
filename = 'raw_re';
out_dir = fullfile('..','matrices','raw_tensors');
save(fullfile(out_dir, filename),'tensor','-v7.3');
disp(['done! saved as ', filename, '.mat! ♪(´▽｀)'])
clear data;
toc

end

