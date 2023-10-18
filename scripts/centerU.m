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

end

