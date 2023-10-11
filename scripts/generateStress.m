function stress = generateStress(data,vars)
% input:
% data: processed readBox.m data folder path
% vars: variables used to generate stress vector

% output:
% result:   Reynolds Stress component for the two variables

var1 = vars(1); var2 = vars(2);
if var1 == 'u'; val1 = 1; end
if var1 == 'v'; val1 = 2; end
if var1 == 'w'; val1 = 3; end
if var2 == 'u'; val2 = 1; end
if var2 == 'v'; val2 = 2; end
if var2 == 'w'; val2 = 3; end

% step 1: find the time-averaged velocity profiles
tic
disp('averaging velocity profiles...')
[var1Bar,var2Bar] = overbar(data,val1,val2);
toc

% step 2: calculate fluctuation
tic
disp('calculating fluctuation...')
[fluc1,fluc2] = fluc(data,var1Bar,var2Bar,val1,val2);
toc

% step 3: find combined fluctuation
tic
disp('combining flucuations...')
fluctuation = fluc1 .* fluc2;
plotFluc(val1,val2,fluctuation)
toc

% step 4: calculate combined fluctuation mean
tic
disp('finalizing stress component...')
stress = mean(fluctuation,1);
stress = permute(stress,[2,3,1]);
plotStress(stress,val1,val2);
toc

% step 4.5: average stress over yvals...?

% step 5: cleanup!
clear fluc1 fluc2 fluctuation

end

