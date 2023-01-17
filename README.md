# DYNACT2

## Workflow:
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