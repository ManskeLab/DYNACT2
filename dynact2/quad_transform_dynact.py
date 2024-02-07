import os
import re
import sys
import argparse
import SimpleITK as sitk

from transform import resampleFullExtent




if __name__ == "__main__":
    # Parse input arguments
    parser = argparse.ArgumentParser()
    parser.add_argument("dynact_resampled_path", type=str, help="Path to DYNACT resampled images")
    parser.add_argument("wbct_path", type=str, help="Path to WBCT quad images")
    parser.add_argument("movement", type=str, help="ABAD, OPP, or KEY")
    parser.add_argument("tfm_path", type=str, help="Path to between frame tfms")
    parser.add_argument("output_path", type=str, help="Output path")
    args = parser.parse_args()

    dynact_resampled_path = args.dynact_resampled_path
    wbct_path = args.wbct_path
    movement = args.movement
    tfm_path = args.tfm_path
    output_path = args.output_path

    # Get list of resampled images (sorted)
    resampled_files = os.listdir(dynact_resampled_path)
    resampled_files = sorted(resampled_files, key=lambda s: int(re.search(r'\d+', s).group()))

    # Get list of TFMs (sorted)
    tfm_files = os.listdir(tfm_path)
    tfm_files = sorted(tfm_files, key=lambda s: int(re.search(r'\d+', s).group()))

    mc1_tfm_files = [m for m in tfm_files if "MC1" in m]
    trp_tfm_files = [t for t in tfm_files if "TRP" in t]

    # Get quads for TRP and MC1
    if not (movement == "ABAD" or movement == "OPP" or movement == "KEY"):
        sys.exit()

    study_id = wbct_path.split(str("/"))[-1][:-5]
    mc1_q = sitk.ReadImage(os.path.join(wbct_path, study_id + "_WBCT_CROP_PERI_MC1_BB_REORIENT_" + movement + "_TRANSF_Q.nii"), sitk.sitkUInt8)
    mc1_q1 = sitk.ReadImage(os.path.join(wbct_path, study_id + "_WBCT_CROP_PERI_MC1_BB_REORIENT_" + movement + "_TRANSF_Q1.nii"), sitk.sitkUInt8)
    mc1_q2 = sitk.ReadImage(os.path.join(wbct_path, study_id + "_WBCT_CROP_PERI_MC1_BB_REORIENT_" + movement + "_TRANSF_Q2.nii"), sitk.sitkUInt8)
    mc1_q3 = sitk.ReadImage(os.path.join(wbct_path, study_id + "_WBCT_CROP_PERI_MC1_BB_REORIENT_" + movement + "_TRANSF_Q3.nii"), sitk.sitkUInt8)
    mc1_q4 = sitk.ReadImage(os.path.join(wbct_path, study_id + "_WBCT_CROP_PERI_MC1_BB_REORIENT_" + movement + "_TRANSF_Q4.nii"), sitk.sitkUInt8)
    trp_q = sitk.ReadImage(os.path.join(wbct_path, study_id + "_WBCT_CROP_PERI_TRP_BB_REORIENT_" + movement + "_TRANSF_Q.nii"), sitk.sitkUInt8)
    trp_q1 = sitk.ReadImage(os.path.join(wbct_path, study_id + "_WBCT_CROP_PERI_TRP_BB_REORIENT_" + movement + "_TRANSF_Q1.nii"), sitk.sitkUInt8)
    trp_q2 = sitk.ReadImage(os.path.join(wbct_path, study_id + "_WBCT_CROP_PERI_TRP_BB_REORIENT_" + movement + "_TRANSF_Q2.nii"), sitk.sitkUInt8)
    trp_q3 = sitk.ReadImage(os.path.join(wbct_path, study_id + "_WBCT_CROP_PERI_TRP_BB_REORIENT_" + movement + "_TRANSF_Q3.nii"), sitk.sitkUInt8)
    trp_q4 = sitk.ReadImage(os.path.join(wbct_path, study_id + "_WBCT_CROP_PERI_TRP_BB_REORIENT_" + movement + "_TRANSF_Q4.nii"), sitk.sitkUInt8)


    # Transform the 4 quads for MC1 and TRP between frames
    for i in range(0, len(mc1_tfm_files), 1):
        frame = re.findall(r'\d+', mc1_tfm_files[i])
        frame_1 = int(frame[0])
        frame_2 = int(frame[1])

        fixed = resampled_files[i+1]

        print(frame)
        print(fixed)
        print(mc1_tfm_files[i])
        print()
        tfm = sitk.ReadTransform(os.path.join(tfm_path, mc1_tfm_files[i]))
        resampled_q = resampleFullExtent(mc1_q, sitk.ReadImage(os.path.join(dynact_resampled_path, fixed)), tfm)
        resampled_q1 = resampleFullExtent(mc1_q1, sitk.ReadImage(os.path.join(dynact_resampled_path, fixed)), tfm)
        resampled_q2 = resampleFullExtent(mc1_q2, sitk.ReadImage(os.path.join(dynact_resampled_path, fixed)), tfm)
        resampled_q3 = resampleFullExtent(mc1_q3, sitk.ReadImage(os.path.join(dynact_resampled_path, fixed)), tfm)
        resampled_q4 = resampleFullExtent(mc1_q4, sitk.ReadImage(os.path.join(dynact_resampled_path, fixed)), tfm)

        sitk.WriteImage(resampled_q, os.path.join(output_path, "VOLUME_" + str(frame_1) + "_TO_" + str(frame_2) + "_MC1_MASK_REG_Q.nii"))
        sitk.WriteImage(resampled_q1, os.path.join(output_path, "VOLUME_" + str(frame_1) + "_TO_" + str(frame_2) + "_MC1_MASK_REG_Q1.nii"))
        sitk.WriteImage(resampled_q2, os.path.join(output_path, "VOLUME_" + str(frame_1) + "_TO_" + str(frame_2) + "_MC1_MASK_REG_Q2.nii"))
        sitk.WriteImage(resampled_q3, os.path.join(output_path, "VOLUME_" + str(frame_1) + "_TO_" + str(frame_2) + "_MC1_MASK_REG_Q3.nii"))
        sitk.WriteImage(resampled_q4, os.path.join(output_path, "VOLUME_" + str(frame_1) + "_TO_" + str(frame_2) + "_MC1_MASK_REG_Q4.nii"))

    for i in range(0, len(trp_tfm_files), 1):
        frame = re.findall(r'\d+', trp_tfm_files[i])
        frame_1 = int(frame[0])
        frame_2 = int(frame[1])

        fixed = resampled_files[i+1]

        print(frame)
        print(fixed)
        print(trp_tfm_files[i])
        print()
        tfm = sitk.ReadTransform(os.path.join(tfm_path, trp_tfm_files[i]))
        resampled_q = resampleFullExtent(trp_q, sitk.ReadImage(os.path.join(dynact_resampled_path, fixed)), tfm)
        resampled_q1 = resampleFullExtent(trp_q1, sitk.ReadImage(os.path.join(dynact_resampled_path, fixed)), tfm)
        resampled_q2 = resampleFullExtent(trp_q2, sitk.ReadImage(os.path.join(dynact_resampled_path, fixed)), tfm)
        resampled_q3 = resampleFullExtent(trp_q3, sitk.ReadImage(os.path.join(dynact_resampled_path, fixed)), tfm)
        resampled_q4 = resampleFullExtent(trp_q4, sitk.ReadImage(os.path.join(dynact_resampled_path, fixed)), tfm)

        sitk.WriteImage(resampled_q, os.path.join(output_path, "VOLUME_" + str(frame_1) + "_TO_" + str(frame_2) + "_TRP_MASK_REG_Q.nii"))
        sitk.WriteImage(resampled_q1, os.path.join(output_path, "VOLUME_" + str(frame_1) + "_TO_" + str(frame_2) + "_TRP_MASK_REG_Q1.nii"))
        sitk.WriteImage(resampled_q2, os.path.join(output_path, "VOLUME_" + str(frame_1) + "_TO_" + str(frame_2) + "_TRP_MASK_REG_Q2.nii"))
        sitk.WriteImage(resampled_q3, os.path.join(output_path, "VOLUME_" + str(frame_1) + "_TO_" + str(frame_2) + "_TRP_MASK_REG_Q3.nii"))
        sitk.WriteImage(resampled_q4, os.path.join(output_path, "VOLUME_" + str(frame_1) + "_TO_" + str(frame_2) + "_TRP_MASK_REG_Q4.nii"))