# DYNACT2

## Workflow:
1. Run the graph cut segmentation on the WBCT scan
2. Downsample WBCT image to DYNACT volume #1 spacing
3. Reorient WBCT image to DYNACT volume #1 orientation (should be LAS)
4. Initialize registration using ITK-SNAP (manual alignment in the registration function)
    - Make sure to save the transform for the initialization as a text file
5. Run the registration
6. Reorient the WBCT segmentation image to the DYNACT volume #1 orientation
7. Transform the segmentation to the DYNACT volume #1 image
8. Run the sequential registration
9. Compute metrics