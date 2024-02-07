"""
compute_motion.py

Created by:   Michael T. Kuczynski
Created on:   Jan. 11, 2021
"""

import os
import re
import sys
import argparse
import numpy as np
import SimpleITK as sitk

from mod_misc.colours import Colours
from mod_biomech.calc_coord_systems import (
    calculate_mc1_scs,
    calculate_trp_scs,
    transform_point,
)

# Global variable for debugging
debug = False


def compute_angles(R_relative):
    """
    Function to compute joint rotations by decomposing the input rotation matrix.

    alpha (a) = abduction-adduction angle (X_MC1)
    beta  (b) = axial rotation (Floating axis)
    gama  (g) = flexion-extension (Z_TRP)

    Relative rotation matrix is assumed to have the following form:
    Rxyz = Rz * Ry * Rx
    Rxyz = 
        [ cos(b)cos(g)   (sin(a)sin(b)cos(g) + cos(a)sin(g))   (-cos(a)sin(b)cos(g) + sin(a)sin(g)) ]
        [ -cos(b)sin(g)  (-sin(a)sin(b)sin(g) + cos(a)cos(g))   (cos(a)sin(b)sin(g) + sin(a)cos(g)) ]
        [ sin(b)                    -sin(a)cos(b)                         cos(a)cos(b)              ]

    Parameters
    ----------
    R_relative : list

    Returns
    -------
    angles : list
    """
    beta = np.arcsin(R_relative[2, 0])
    alpha = np.arcsin(-1 * R_relative[2, 1] / np.cos(beta))
    gama = np.arcsin(-1 * R_relative[1, 0] / np.cos(beta))

    angles = [alpha, beta, gama]
    return angles


def compute_translations(R_relative, curr_origin, prev_origin):
    """
    Computes joint translations at a specific DYNACT frame. Translations are
    computed for the origin of the MC1 relative to the TRP.

    Parameters
    ----------
    R_relative : list
        Matrix to move from the MC1 coordinates to the TRP coordinates

    curr_origin : list
        MC1 origin at the current DYNACT frame

    prev_origin : string
        MC1 origin at the previous DYNACT frame

    Returns
    -------
    translations : list
        List of the X, Y, and Z translations of the MC1 relative to the TRP

    transformed_origin : list
        Origin for the next frame
    """
    transformed_origin = R_relative.dot(
        np.array([float(curr_origin[0]), float(curr_origin[1]), float(curr_origin[2])])
    )

    t_x = str(float(transformed_origin[0]) - float(prev_origin[0]))
    t_y = str(float(transformed_origin[1]) - float(prev_origin[1]))
    t_z = str(float(transformed_origin[2]) - float(prev_origin[2]))

    translations = [t_x, t_y, t_z]
    return translations, transformed_origin


def dynact_frame_transform(dynact_tfms_dir, mc1_pnts_dynact, trp_pnts_dynact, R_relative):
    """
    Transform MC1 and TRP points from XCT to CT, CT to DYNACT frame #1, and
    between DYNACT frames. Joint angles and translations are then computed for
    each DYNACT frame.

    Parameters
    ----------
    dynact_tfms_dir : list

    mc1_pnts_dynact : list
        Anatommical landmarks for the MC1.
        Contains 3 points: 1) LDT, 2) MDT, 3) M1TJ (origin)

    trp_pnts_dynact : list
        Anatommical landmarks for the TRP.
        Contains 4 points: 1) TM1J (origin), 2) TM2J, 3) TSTJ, 4) TDET

    Returns
    -------
    rotations : list
        The abduction/adduction, flexion/extension, and axial rotation angles

    translations : list
        The X, Y, and Z translations of the MC1
    """
    # mc1_pnt1_dynact = -0.30759625336368585 # mc1_pnts_dynact[0]
    # mc1_pnt2_dynact = -0.021799076982359143 # mc1_pnts_dynact[1]
    # mc1_pnt3_dynact = -0.17220778671814682 # mc1_pnts_dynact[2]
    # trp_pnt1_dynact = 5.4457882165785145 # trp_pnts_dynact[0]
    # trp_pnt2_dynact = -2.3659886422985803 # trp_pnts_dynact[1]
    # trp_pnt3_dynact = 0.6046209420609058 # trp_pnts_dynact[2]
    # trp_pnt4_dynact =  # trp_pnts_dynact[3]
    saddle = [5.4457882165785145, -2.3659886422985803, 0.6046209420609058]
 
    # Abduction, flexion, and internal rotation are positive
    # Adduction, extension, and external rotation are negative
    angle_list = compute_angles(R_relative)
    ab_ad = np.rad2deg(angle_list[0])
    ax_rot = np.rad2deg(angle_list[1])
    flex_ext = np.rad2deg(angle_list[2])

    ab_ad_arr = np.arange(59).astype(str)
    flex_ext_arr = np.arange(59).astype(str)
    ax_rot_arr = np.arange(59).astype(str)
    o_x = np.arange(59).astype(str)
    o_y = np.arange(59).astype(str)
    o_z = np.arange(59).astype(str)
    t_x = np.arange(59).astype(str)
    t_y = np.arange(59).astype(str)
    t_z = np.arange(59).astype(str)

    ab_ad_arr.shape = (59, 1)
    flex_ext_arr.shape = (59, 1)
    ax_rot_arr.shape = (59, 1)
    o_x.shape = (59, 1)
    o_y.shape = (59, 1)
    o_z.shape = (59, 1)
    t_x.shape = (59, 1)
    t_y.shape = (59, 1)
    t_z.shape = (59, 1)

    ab_ad_arr[0] = str(ab_ad)
    flex_ext_arr[0] = str(flex_ext)
    ax_rot_arr[0] = str(ax_rot)

    transformed_origin = R_relative.dot(
        np.array(
            [
                float(saddle[0]),
                float(saddle[1]),
                float(saddle[2]),
            ]
        )
    )
    o_x[0] = str(transformed_origin[0])
    o_y[0] = str(transformed_origin[1])
    o_z[0] = str(transformed_origin[2])

    if debug:
        print(Colours.BLUE + "\t Printing joint motion for frame #1:" + Colours.WHITE)
        print("\t Abduction-Adduction: " + str(ab_ad))
        print("\t Flexion-Extension: " + str(flex_ext))
        print("\t Internal-External Rotation: " + str(ax_rot))
        print()
        print("\t Translation X: " + str(o_x[0]))
        print("\t Translation Y: " + str(o_y[0]))
        print("\t Translation Z: " + str(o_z[0]))
        print()

    # Transform between DYNACT frames
    for i in range(2, 58):
        # Transform to the next DYNACT frame
        # MC1
        dynact_reg_path_mc1 = os.path.join(
            dynact_tfms_dir, "VOLUME_" + str(i-1) + "_TO_" + str(i) + "_MC1_REG.tfm"
        )
        dynact_next_reg_mc1_tfm = sitk.ReadTransform(dynact_reg_path_mc1)

        mc1_pnt1_dynact_frame = transform_point(
            dynact_next_reg_mc1_tfm, mc1_pnts_dynact[0]
        )
        mc1_pnt2_dynact_frame = transform_point(
            dynact_next_reg_mc1_tfm, mc1_pnts_dynact[1]
        )
        mc1_pnt3_dynact_frame = transform_point(
            dynact_next_reg_mc1_tfm, mc1_pnts_dynact[2]
        )

        # TRP
        dynact_reg_path_trp = os.path.join(
            dynact_tfms_dir, "VOLUME_" + str(i-1) + "_TO_" + str(i) + "_TRP_REG.tfm"
        )
        dynact_next_reg_trp_tfm = sitk.ReadTransform(dynact_reg_path_trp)

        trp_pnt1_dynact_frame = transform_point(
            dynact_next_reg_trp_tfm, trp_pnts_dynact[0]
        )
        trp_pnt2_dynact_frame = transform_point(
            dynact_next_reg_trp_tfm, trp_pnts_dynact[1]
        )
        trp_pnt3_dynact_frame = transform_point(
            dynact_next_reg_trp_tfm, trp_pnts_dynact[2]
        )
        # trp_pnt4_dynact_frame = transform_point(
        #     dynact_next_reg_trp_tfm, trp_pnt4_dynact
        # )

        # Calculate joint angles for testing
        # Matricies from these functions are returned in the following format:
        # [Xx  Xy  Xz]
        # [Yx  Yy  Yz]
        # [Zx  Zy  Zz]
        xct_mc1_scs = np.array(
            # [mc1_pnt1_dynact_frame[0], mc1_pnt1_dynact_frame[1], mc1_pnt1_dynact_frame[2]]
            # calculate_mc1_scs(
                [mc1_pnt1_dynact_frame, mc1_pnt2_dynact_frame, mc1_pnt3_dynact_frame]
            # )
        )
        xct_trp_scs = np.array(
            # [trp_pnt1_dynact_frame[0], trp_pnt1_dynact_frame[1], trp_pnt1_dynact_frame[2]]
            # calculate_trp_scs(
                [
                    trp_pnt1_dynact_frame,
                    trp_pnt2_dynact_frame,
                    trp_pnt3_dynact_frame,
                ]
            #         # trp_pnt4_dynact_frame,
            #     ]
            # )
        )

        # M_scs_MC1 = np.array([xct_mc1_scs[0], xct_mc1_scs[1], xct_mc1_scs[2]])
        # M_scs_TRP = np.array([xct_trp_scs[0], xct_trp_scs[1], xct_trp_scs[2]])
        M_scs_MC1 = np.array([xct_mc1_scs[0].T, xct_mc1_scs[1].T, xct_mc1_scs[2].T])
        M_scs_TRP = np.array([xct_trp_scs[0].T, xct_trp_scs[1].T, xct_trp_scs[2].T])
        # print(M_scs_MC1)
        # print(M_scs_TRP)
        # sys.exit()

        # Calculate angle of MC1 relative to TRP
        R_relative = np.linalg.inv(M_scs_TRP) * M_scs_MC1

        # Abduction, flexion, and internal rotation are positive
        # Adduction, extension, and external rotation are negative
        angle_list = compute_angles(R_relative)
        ab_ad = np.rad2deg(angle_list[0])
        ax_rot = np.rad2deg(angle_list[1])
        flex_ext = np.rad2deg(angle_list[2])

        # if debug:
        #     print(Colours.PURPLE + "\t DEBUG: Points at frame " + str(i) + ":" + Colours.WHITE)
        #     print("\t MC1:")
        #     print("\t (" + str(mc1_pnt1_dynact_frame) + ")")
        #     print("\t (" + str(mc1_pnt2_dynact_frame) + ")")
        #     print("\t (" + str(mc1_pnt3_dynact_frame) + ")")
        #     print("\t TRP:")
        #     print("\t (" + str(trp_pnt1_dynact_frame) + ")")
        #     print("\t (" + str(trp_pnt2_dynact_frame) + ")")
        #     print("\t (" + str(trp_pnt3_dynact_frame) + ")")
        #     # print("\t (" + str(trp_pnt4_dynact_frame) + ")")
        #     print("\t ANGLES:")
        #     print("\t AD/AD: " + str(ab_ad))
        #     print("\t FL/EX: " + str(flex_ext))
        #     print("\t ROT: " + str(ax_rot))
        #     print()

        # translation
        prev_origin = [o_x[i - 1], o_y[i - 1], o_z[i - 1]]
        t, o = compute_translations(R_relative, [o_x[i], o_y[i], o_z[i]], prev_origin)
        t_x[i - 1] = t[0]
        t_y[i - 1] = t[1]
        t_z[i - 1] = t[2]
        o_x[i - 1] = o[0]
        o_y[i - 1] = o[1]
        o_z[i - 1] = o[2]

        ab_ad_arr[i - 1] = str(ab_ad)
        flex_ext_arr[i - 1] = str(flex_ext)
        ax_rot_arr[i - 1] = str(ax_rot)

        # Keep commented out to reduce the processing time
        # if debug:
        #     print(Colours.BLUE + '\t Printing joint motion for frame #' + str(i-1) + ':' + Colours.WHITE)
        #     print('\t Abduction-Adduction: ' + str(ab_ad))
        #     print('\t Flexion-Extension: ' + str(flex_ext))
        #     print('\t Internal-External Rotation: ' + str(ax_rot))
        #     print()
        #     print('\t Translation X: ' + str(t_x[i-1]))
        #     print('\t Translation Y: ' + str(t_y[i-1]))
        #     print('\t Translation Z: ' + str(t_z[i-1]))
        #     print()

    rotations = [ab_ad_arr, flex_ext_arr, ax_rot_arr]
    translations = [t_x, t_y, t_z]
    return rotations, translations


def xct_to_dynact_transform(study_id, point_files, wbct_to_dynact_tfms, dynact_tfm_dir):
    """
    Transforms XCT points to the DYNACT space to compute joint motion.

    Parameters
    ----------

    Returns
    -------
    arr : list
    """
    # ----------------------------------------------------------#
    #   Step 1: Setup                                           #
    # ----------------------------------------------------------#
    # # SCS point files
    # mc1_pnts_list = point_files[0]
    # trp_pnts_list = point_files[1]

    # # WBCT to DYNACT transforms
    # wbct_to_dynact_mc1_tfm = wbct_to_dynact_tfms[0]
    # wbct_to_dynact_trp_tfm = wbct_to_dynact_tfms[1]

    # # Strip the list to create a seperate list for each point
    # mc1_pnt1 = [float(s) for s in mc1_pnts_list[0].split(",")]
    # mc1_pnt2 = [float(s) for s in mc1_pnts_list[1].split(",")]
    # mc1_pnt3 = [float(s) for s in mc1_pnts_list[2].split(",")]

    # trp_pnt1 = [float(s) for s in trp_pnts_list[0].split(",")]
    # trp_pnt2 = [float(s) for s in trp_pnts_list[1].split(",")]
    # trp_pnt3 = [float(s) for s in trp_pnts_list[2].split(",")]
    # trp_pnt4 = [float(s) for s in trp_pnts_list[3].split(",")]

    # if debug:
    #     print(Colours.PURPLE + "\t DEBUG: Points read in:" + Colours.WHITE)
    #     print("\t MC1:")
    #     print("\t (" + str(mc1_pnt1) + ")")
    #     print("\t (" + str(mc1_pnt2) + ")")
    #     print("\t (" + str(mc1_pnt3) + ")")
    #     print("\t TRP:")
    #     print("\t (" + str(trp_pnt1) + ")")
    #     print("\t (" + str(trp_pnt2) + ")")
    #     print("\t (" + str(trp_pnt3) + ")")
    #     print("\t (" + str(trp_pnt4) + ")")
    #     print()

    # # --------------------------------------------------------------#
    # #   Step 2: Transform points from WBCT to DYNACT image space    #
    # # --------------------------------------------------------------#
    # # Nifti to ITK World coordinates (Flip X and Y axes to go from VTK to ITK coordinates)
    # mc1_pnt1 = [-1 * mc1_pnt1[0], -1 * mc1_pnt1[1], mc1_pnt1[2]]
    # mc1_pnt2 = [-1 * mc1_pnt2[0], -1 * mc1_pnt2[1], mc1_pnt2[2]]
    # mc1_pnt3 = [-1 * mc1_pnt3[0], -1 * mc1_pnt3[1], mc1_pnt3[2]]

    # trp_pnt1 = [-1 * trp_pnt1[0], -1 * trp_pnt1[1], trp_pnt1[2]]
    # trp_pnt2 = [-1 * trp_pnt2[0], -1 * trp_pnt2[1], trp_pnt2[2]]
    # trp_pnt3 = [-1 * trp_pnt3[0], -1 * trp_pnt3[1], trp_pnt3[2]]
    # trp_pnt4 = [-1 * trp_pnt4[0], -1 * trp_pnt4[1], trp_pnt4[2]]

    mc1_pnt1 = [-0.30759625336368585, -0.021799076982359143, -0.17220778671814682]
    # mc1_pnt2 = -0.021799076982359143
    # mc1_pnt3 = -0.17220778671814682
    trp_pnt1 = [5.4457882165785145, -2.3659886422985803, 0.6046209420609058]
    # trp_pnt2 = -2.3659886422985803
    # trp_pnt3 = 0.6046209420609058

    # MC1
    wbct_to_dynact_mc1_tfm = "D:/OneDrive - University of Calgary/DYNACT2/models/DYNACT2_200/DYNACT2_200_WBCT/DYNACT2_200_MC1_WBCT_TO_ABAD_REG.tfm"
    wbct2dynact_mc1_tfm = sitk.ReadTransform(wbct_to_dynact_mc1_tfm)

    mc1_pnt1_dynact = transform_point(wbct2dynact_mc1_tfm, mc1_pnt1)
    # mc1_pnt2_dynact = transform_point(wbct2dynact_mc1_tfm, mc1_pnt2)
    # mc1_pnt3_dynact = transform_point(wbct2dynact_mc1_tfm, mc1_pnt3)

    # TRP
    wbct_to_dynact_trp_tfm = "D:/OneDrive - University of Calgary/DYNACT2/models/DYNACT2_200/DYNACT2_200_WBCT/DYNACT2_200_TRP_WBCT_TO_ABAD_REG.tfm"
    wbct2dynact_trp_tfm = sitk.ReadTransform(wbct_to_dynact_trp_tfm)

    trp_pnt1_dynact = transform_point(wbct2dynact_trp_tfm, trp_pnt1)
    # trp_pnt2_dynact = transform_point(wbct2dynact_trp_tfm, trp_pnt2)
    # trp_pnt3_dynact = transform_point(wbct2dynact_trp_tfm, trp_pnt3)
    # trp_pnt4_dynact = transform_point(wbct2dynact_trp_tfm, trp_pnt4)

    if debug:
        # print(
        #     Colours.PURPLE + "\t DEBUG: Points transformed to CT space:" + Colours.WHITE
        # )
        # print("\t MC1:")
        # print("\t mc1_pnt1_dynact: " + str(mc1_pnt1_dynact))
        # print("\t mc1_pnt2_dynact: " + str(mc1_pnt2_dynact))
        # print("\t mc1_pnt3_dynact: " + str(mc1_pnt3_dynact))
        # print("\t TRP:")
        # print("\t trp_pnt1_dynact: " + str(trp_pnt1_dynact))
        # print("\t trp_pnt2_dynact: " + str(trp_pnt2_dynact))
        # print("\t trp_pnt3_dynact: " + str(trp_pnt3_dynact))
        # print("\t trp_pnt4_dynact: " + str(trp_pnt4_dynact))
        print()

    # Calculate joint angles for testing
    # Matricies from these functions are returned in the following format:
    # [Xx  Xy  Xz]
    # [Yx  Yy  Yz]
    # [Zx  Zy  Zz]
    # xct_mc1_scs = np.array(
    #     calculate_mc1_scs([mc1_pnt1_dynact, mc1_pnt2_dynact, mc1_pnt3_dynact])
    # )
    # xct_trp_scs = np.array(
    #     calculate_trp_scs(
    #         [trp_pnt1_dynact, trp_pnt2_dynact, trp_pnt3_dynact, trp_pnt4_dynact]
    #     )
    # )
    xct_mc1_scs = np.array([[1.0, -7.137843318449574e-17, 7.999813207750574e-17],
                               [3.0611973396971194e-16, 1.5265566588595902e-16, -1.0000000000000002],
                               [-2.4256485796449615e-31, 1.0, 1.8041124150158794e-16]]
        )
    xct_trp_scs = np.array([[0.9999999999999999, 4.508502753708943e-17, 2.772328417334125e-17],
                               [-2.7694344047340325e-17, -9.683833596119129e-14, -1.0],
                               [2.878480065220591e-26, 0.9999999999999999, -9.681058038557566e-14]]
    )

    # Matricies for axes should be formatted as follows:
    # Rxyz = [Rz  Ry  Rx]
    # Rxyz = [Zx  Yx  Xx]
    #        [Zy  Yy  Xy]
    #        [Zz  Yz  Xz]
    M_scs_MC1 = np.array([xct_mc1_scs[0].T, xct_mc1_scs[1].T, xct_mc1_scs[2].T])
    M_scs_TRP = np.array([xct_trp_scs[0].T, xct_trp_scs[1].T, xct_trp_scs[2].T])

    # Calculate angle of MC1 relative to TRP
    R_relative = np.linalg.inv(M_scs_TRP) * M_scs_MC1

    # if debug:
    #     print(Colours.PURPLE + "\t DEBUG: XCT coordinate systems:" + Colours.WHITE)
    #     print("\t M_scs_MC1: \n\t " + str(M_scs_MC1).replace("\n", "\n \t"))
    #     print("\t M_scs_TRP: \n\t " + str(M_scs_TRP).replace("\n", "\n \t"))
    #     print(
    #         Colours.PURPLE + "\t DEBUG: XCT relative rotation matrix:" + Colours.WHITE
    #     )
    #     print("\t R_relative: \n\t " + str(R_relative).replace("\n", "\n \t"))
    #     print()

    # mc1_pnts_dynact = [mc1_pnt1_dynact, mc1_pnt2_dynact, mc1_pnt3_dynact]
    # trp_pnts_dynact = [
    #     trp_pnt1_dynact,
    #     trp_pnt2_dynact,
    #     trp_pnt3_dynact,
    #     # trp_pnt4_dynact
    # ]
    rotations, translations = dynact_frame_transform(
        dynact_tfm_dir, M_scs_MC1, M_scs_TRP, R_relative
    )

    ab_ad_arr = rotations[0]
    flex_ext_arr = rotations[1]
    ax_rot_arr = rotations[2]
    t_x = translations[0]
    t_y = translations[1]
    t_z = translations[2]

    arr = np.hstack([ab_ad_arr, flex_ext_arr, ax_rot_arr, t_x, t_y, t_z])
    return arr


def main(study_id, dynact_tfm_dir, point_files):
    """
    Main function to compute joint angles and translations.

    Parameters
    ----------

    Returns
    -------
    arr : list
        A list containing the rotations and translations
    """
    # -------------------------------------------------------#
    #   Step 1: Setup inputs                                #
    # -------------------------------------------------------#

    # -------------------------------------------------------#
    #   Step 2: Read in the points from text file           #
    # -------------------------------------------------------#
    # There should be 3 points for the MC1 and 4 for the TRP
    # Points are picked in the WBCT space
    # mc1_pnts_file = point_files[0]
    # trp_pnts_file = point_files[1]

    # mc1_pnts_list = [None] * 3
    # trp_pnts_list = [None] * 4

    # print(
    #     Colours.BLUE
    #     + "\t Reading in MC1 points: "
    #     + Colours.WHITE
    #     + "{}".format(mc1_pnts_file)
    # )
    # try:
    #     with open(mc1_pnts_file) as f:
    #         mc1_pnts_list = [line.rstrip("\n") for line in f]
    # except FileNotFoundError:
    #     print(Colours.RED + "ERROR: File does not exist!" + Colours.WHITE)
    #     sys.exit(1)

    # print(
    #     Colours.BLUE
    #     + "\t Reading in TRP points: "
    #     + Colours.WHITE
    #     + "{}".format(trp_pnts_file)
    # )
    # try:
    #     with open(trp_pnts_file) as f:
    #         trp_pnts_list = [line.rstrip("\n") for line in f]
    # except FileNotFoundError:
    #     print(Colours.RED + "ERROR: File does not exist!" + Colours.WHITE)
    #     sys.exit(1)

    # points_list = [mc1_pnts_list, trp_pnts_list]
    points_list = [0,0,0]

    # -------------------------------------------------------#
    #   Step 3: Transform XCT points to DYNACT space        #
    # -------------------------------------------------------#
    arr = xct_to_dynact_transform(200, point_files, None, dynact_tfm_dir)

    return arr


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("dynact_tfm_dir", type=str)
    parser.add_argument("mc1_point_file", type=str, help="MC1 SCS point text file")
    parser.add_argument("trp_point_file", type=str, help="TRP SCS point text file")
    parser.add_argument("output_path", type=str, help="The directory for any outputs")
    parser.add_argument("-d", "--debug", nargs="?", type=bool, default=False)

    args = parser.parse_args()
    dynact_tfm_dir = args.dynact_tfm_dir
    mc1_point_file = args.mc1_point_file
    trp_point_file = args.trp_point_file
    output_path = args.output_path
    debug = args.debug

    point_files = [mc1_point_file, trp_point_file]

    # Extract study ID
    # Make it OS independent
    # Format of external SSD: /Manskelab/ManskelabProjects/DYNACT2/models/...
    # study_id =  outer_r = re.search('models' + str(os.sep) + '(.+?)' + str(os.sep), dynact_tfm_dir).group(1)
    study_id = 200


    # Create an array for the roatation/translantion results
    header_arr = np.array([["Frame", "AbAd", "FlexExt", "Rot", "X", "Y", "Z"]], dtype=object)
    frame_arr = np.arange(59).astype(str)
    frame_arr.shape = (59, 1)

    print(
        Colours.BOLD
        + "Computing angles for "
        + str(study_id)
        + "..."
        + Colours.WHITE
    )

    output_arr = frame_arr
    output_arr = np.hstack([output_arr, main(study_id, dynact_tfm_dir, point_files)])
    output_arr = np.vstack([header_arr, output_arr])
    output_arr = output_arr.astype(str)

    print(Colours.BOLD + "Writing out values to CSV..." + Colours.WHITE)
    print()
    output_csv = os.path.join(output_path, str(study_id) + "_angles.csv")
    np.savetxt(output_csv, output_arr, delimiter=",", fmt="%s")

    print()
    print(Colours.BOLD + "Done!")
