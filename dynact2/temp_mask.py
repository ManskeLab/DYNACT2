import SimpleITK as sitk
import numpy as np

img = sitk.ReadImage("D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_003\\DYNACT2_003_HRpQCT\\stack_reg_output\\FULL_IMAGE.nii", sitk.sitkFloat32)
dst_mask = sitk.ReadImage("D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_003\\DYNACT2_003_HRpQCT\\stack_reg_output\\FULL_IMAGE_DST_MASK.nii", sitk.sitkUInt8)
prx_mask = sitk.ReadImage("D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_003\\DYNACT2_003_HRpQCT\\stack_reg_output\\FULL_IMAGE_PRX_MASK.nii", sitk.sitkUInt8)

dst_mask = sitk.BinaryThreshold(dst_mask, 1, 127, 1, 0)
img_masked = sitk.Mask(img, sitk.InvertIntensity(dst_mask, 1))
sitk.WriteImage(img_masked,
                "D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_003\\DYNACT2_003_HRpQCT\\stack_reg_output\\temp.nii")

joint_mask = dst_mask + prx_mask
sitk.WriteImage(joint_mask,
                "D:\\OneDrive - University of Calgary\\DYNACT2\\models\\DYNACT2_003\\DYNACT2_003_HRpQCT\\stack_reg_output\\temp.nii")
