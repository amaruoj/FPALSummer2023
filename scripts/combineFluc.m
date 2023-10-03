function combineFluc(folder)
% input:
% folder:   folder containing fluctuation files

% output:
% fluc: combined fluctuations saved to directory for further processing

% data retrieval
mat = dir(fullfile(folder,'*.mat'));
nmat = length(mat) / 2;

% loop over saved matrices
for i = 1:nmat
    
    % extract data
    file1 = append('fluc1_',num2str(i),'.mat'); file2 = append('fluc2_',num2str(i),'.mat');
    mat1 = load(fullfile(folder,file1)); mat2 = load(fullfile(folder,file2));
    fluc1 = mat1.fluc1; fluc2 = mat2.fluc2;
    
    % combine fluctuations
    fluc12 = fluc1 .* fluc2;
    
    % save resultant matrix
    filename = append('fluc12_',num2str(i));
    out_dir = fullfile('..','matrices','flucs12');
    save(fullfile(out_dir,filename),'fluc12','-v7.3');
    
end

end

