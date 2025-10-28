# DYNACT2 - develop_clean branch
Contains a 'clean' codebase with platform- and user-specific hard-coded scripts removed

## Workflow (Registration):
1. Run the graph cut segmentation on the WBCT scan
2. Downsample WBCT image to DYNACT volume #1 spacing
3. Reorient WBCT image to DYNACT volume #1 orientation (should be LAS)
4. Initialize registration using ITK-SNAP (manual alignment in the registration function)
    - Make sure to save the transform for the initialization as a text file
5. Run the registration
6. ***Optional step:*** in the case that the segmentation doesn't align with the grayscale image after reorientation, resample the segmentation image to match the grayscale image spacing, origin, etc. Then proceed with the workflow. 
7. Reorient the WBCT segmentation image to the DYNACT volume #1 orientation
8. Transform the segmentation to the DYNACT volume #1 image
9. Run the sequential registration
10. Compute metrics

## Kinematics Workflow (scripts in mod_kinematics):
1. Use TMC_JCS repository to create JCS for each bone (XCT). Confirm through manual inspection on pyvista images
2. Use registration .tfm files to transform to WBCT, and then to DYNACT motion frames
3. Calculate joint angles from transformed JCS
4. Use plotting scripts to identify motion cycles
5. Calculate average motion curves per direction, per motion, per subject for JCS axes
6. Plot mean angle curves with CI as in [Van Royen et al. 2024](https://doi.org/10.1177/17531934241229948)
7. Create hysteresis plot as in [Van Royen et al. 2024](https://doi.org/10.1177/17531934241229948) (script in-progress)
