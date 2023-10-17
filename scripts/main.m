function main()
% no inputs, has everything hard coded...

% step 1: post-processing and data restructuring
processData('../planar_data');

% step 2: generating the stress tensor
generateTensor('../output_data');

% step 3: normalizing the radius
radius = normRad('../output_data');

% step 4: normalizing the stress tensor
norm_tensor = normTensor('../output_data');

% step 5: plot the normalized tensor components
plotNormRe(radius, norm_tensor);

end

