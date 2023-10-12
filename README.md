# FPAL Summer 2023 Stress Tensor Exercise -- Amaru Ordóñez-Jacobson
Collection of scripts and figures describing the Reynolds stress tensors of a jet plume designed by Gary Wu, whose data has not been included in this repository (except for two timesteps that are used for debugging). These scripts are designed to analyze the planar dataset collected by Gary – the volumetric dataset would require a slightly different approach due to the different setup of the dataset. 

## Execution
The order for script execution is:
1. `processData.m`, for data post-processing and reshaping.
2. `generateTensor.m`, for generating the raw stress tensor (no normalization)
3. `normTensor.m`, for normalizing the stress tensor
4. `normRadius.m`, for calculating the normalized radius
5. `plotNormRe.m`, for plotting the normalized tensor components against the normalized radius.

Output from `normRadius.m` can be used to debug the raw stress tensor, but only to verify their shape. Working on just running eveything through a `main` function, but it's useful for debugging to run in large chunks.

As of 12 October 2023, normalization scripts need updating -- only tensor calculations have been verified.

## Data Representation
To demonstrate the different debugging steps, I've collected many figures that demonstrate different aspects of the calculation of the stress tensors. In the `figs` folder, I demonstrate critical steps to the tensor calculation, such as mean velocity contours and fluctuation contours. These figures have been saved as both `.png` and `.fig` file extensions for ease of access and ease of editing, respectively. Below is a comprehensive list of the figures included in this repository:
- `data_contour`: A simple data contour plot output from the `processData.m` processing script, demonstrating the density contour at 1 acoustic time unit.
- `meancontour_i`: A contour plot demonstrating the mean of the `i`th component of the velocity.
- `fluccontour_i`: A contour plot demonstrating the fluctuation of the `i`th component of the velocity with its mean velocity.
- `fluctcontour_ij`: A contour plot demonstrating the combined fluctuation of `ij`.
- `stresscontour_ij`: A contour plot demonstrating the `ij` component of the stress tensor.

These figures are for pointing out bugs and for making sure that the profiles are behaving properly.