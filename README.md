# FPAL Summer 2023 Stress Tensor Exercise -- Amaru Ordóñez-Jacobson
Collection of scripts and figures describing the Reynolds stress tensors of a jet plume designed by Gary Wu, whose data has not been included in this repository. These scripts are designed to analyze the planar dataset collected by Gary – the volumetric dataset would require a slightly different approach due to the different setup of the dataset. The order for script execution is:
1. `processData.m`, for data post-processing and reshaping.
2. `generateTensor.m`, for generating the raw stress tensor (no normalization)
3. `normTensor.m`, for normalizing the stress tensor
4. `normRadius.m`, for calculating the normalized radius
5. `plotNormRe.m`, for plotting the normalized tensor components against the normalized radius.

Output from `normRadius.m` can be used to debug the raw stress tensor, but only to verify their shape.