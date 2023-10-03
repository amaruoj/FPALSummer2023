function result = generateStress(mat,vars)
% input:
% data: readBox.m data
% vars: variables used to generate stress vector

% output:
% result:   Reynolds Stress vector for the two variables

var1 = vars(1); var2 = vars(2);
if var1 == 'u'
    val1 = 1;
end
if var1 == 'v'
    val1 = 2;
end
if var1 == 'w'
    val1 = 3;
end
if var2 == 'u'
    val2 = 1;
end
if var2 == 'v'
    val2 = 2;
end
if var2 == 'w'
    val2 = 3;
end

% step 1: find the time-averaged velocity profiles
tic
disp('averaging velocity profiles...')
[var1Bar,var2Bar] = overbar(mat,val1,val2);
toc

% step 2: calculate fluctuation
tic
disp('calculating fluctuation...')
fluc(mat,var1Bar,var2Bar,val1,val2);
toc

% step 3: find combined fluctuation
tic
disp('combining flucuations...')
combineFluc(fullfile('..','matrices','flucs'));
toc

% step 4: calculate combined fluctuation mean
tic
disp('finalizing stress component...')
result = meanFluc(fullfile('..','matrices','flucs12'));
toc

% step 5: average values across + and -yvals
% tic
% disp('cleaning up data...')
% result = finalizeStress(x,vars);
% disp('done! onto the next component of the tensor...')
% toc

end

