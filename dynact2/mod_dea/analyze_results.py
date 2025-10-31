# ----------------------------------------------------------------
# analyze_results.py 
#
# Created by: Chris Brunet
# Created on: June 19, 2025
#
# Analyzes joint contact stress and force outputs from MATLAB DEA program 
#
# Usage: 
#     1. Follow instructions in readme.md
#     2. Run command: 
# 'analyze_results.py {file_path_to_dynact_subjects} {subject_no} -m {motion}'
# ----------------------------------------------------------------

import argparse
import os
import sys
import pyvista as pv
import pandas as pd
import numpy as np

from plot_utils import plot_bones, plot_forces
from mesh_utils import compute_normal_vector

# Parse input args                    
parser = argparse.ArgumentParser()
parser.add_argument("dynact_path", type = str, help = "Base file path for all dynact subjects")
parser.add_argument("subject", type = str, help = "Motion to analyze")
parser.add_argument("-m", type = str, default=None, help = "Motion to analyze")
args = parser.parse_args()
dynact_path = args.dynact_path
subject = args.subject
motion = args.m

# Handle motions argument
allowable_motions = ["ABAD", "KEY", "OPP"]
motions = []
if motion:
  if motion not in allowable_motions:
    print(f"{motion} is not a valid motion. Must be one of: {allowable_motions}")
    sys.exit()
  else:
    motions.append(motion)
else:
  motions = allowable_motions

# Loop through each motion
for motion in motions:

    # Base file paths
    dea_path = os.path.join(dynact_path, f"DYNACT2_{subject}/DYNACT2_{subject}_{motion}/DEA FILES/Outputs")
    matlab_output_path = os.path.join(dea_path, "DEA_Matlab_Outputs")
    ref_mesh_tfms_path = os.path.join(dea_path, 'Reference Mesh Transforms')

    if not os.path.exists(dea_path):
       continue

    print(f"\nSubject: {subject}")
    print(f"Motion: {motion}")
    print(f"DEA Files Path: {dea_path}")

    # get reference frame and initial tfm unless it is frame 1
    ref_frame_csv = pd.read_csv(os.path.join(dea_path, "normal_vector.csv"), header=None)
    ref_frame = int(ref_frame_csv.values[3][0]) + 1
    vol_n_mc1_patch = pv.read(os.path.join(dea_path, f'VOLUME_{ref_frame}_MC1_PATCH.stl'))
    vol_n_mc1_mesh = pv.read(os.path.join(dea_path, f'VOLUME_{ref_frame}_MC1_MESH.stl'))
    initial_center = vol_n_mc1_mesh.center

    all_mc1_jsw_meshes = []
    all_mc1_jsw_patches = []
    all_mc1_stress_patches = []
    all_mc1_stress_meshes = []
    all_stress_values = []
    all_trp_meshes = []
    all_trp_patches = []
    displacements = []

    print("Getting MC1 Bone Forces...")
    forces_df = pd.read_excel(os.path.join(matlab_output_path, "FORCES.xlsx"), header=None)
    forces_df = forces_df.rename(columns={0: 'Frame', 1: 'Fx', 2: 'Fy', 3: 'Fz'})
    forces_df['magnitude'] = np.sqrt(forces_df['Fx']**2 + forces_df['Fy']**2 + forces_df['Fz']**2)

    print("Getting JSW and Stress Files...")
    for i in range(60):
        volume = i+1

        # read stl files
        mc1_mesh = pv.read(os.path.join(dea_path, f'VOLUME_{volume}_MC1_MESH.stl'))
        mc1_patch = pv.read(os.path.join(dea_path, f'VOLUME_{volume}_MC1_PATCH.stl'))
        trp_mesh = pv.read(os.path.join(dea_path, f'VOLUME_{volume}_TRP_MESH.stl'))
        trp_patch = pv.read(os.path.join(dea_path, f'VOLUME_{volume}_TRP_PATCH.stl'))

        # read from mesh -> mesh tfm instead of reg_tfm
        transform_filename = os.path.join(ref_mesh_tfms_path, f'VOL_{ref_frame}_TO_{volume}_MC1_TFM.csv')
        tfm_df = pd.read_csv(transform_filename, header=None)
        tfm = tfm_df.values

        # read JSW and stress files
        mc1_jsw_filename = os.path.join(dea_path, f'VOLUME_{volume}_MC1_PATCH_JSW.xlsx')
        trp_jsw_filename = os.path.join(dea_path, f'VOLUME_{volume}_TRP_PATCH_JSW.xlsx')
        mc1_stress_filename = os.path.join(matlab_output_path, f'VOLUME_{volume}_MC1_STRESS.xlsx')
        mc1_jsw_df = pd.read_excel(mc1_jsw_filename)
        trp_jsw_df = pd.read_excel(trp_jsw_filename)
        stress_df = pd.read_excel(mc1_stress_filename, header=None)

        # process stress values used for CLIM calcs later
        current_stress_values = stress_df.values.flatten()
        current_stress_values = current_stress_values[~np.isnan(current_stress_values)]
        current_stress_values = current_stress_values[(current_stress_values != 0) & (current_stress_values < 100) & (current_stress_values > 0)] 
        all_stress_values.extend(current_stress_values)

        # get JSW and stress values in a list
        mc1_jsw = mc1_jsw_df['jsw'].values
        trp_jsw = trp_jsw_df['jsw'].values
        stress = [i[0] if i[0] != 0 else np.nan for i in stress_df.values]
        
        mc1_patch_jsw = mc1_patch.copy()
        mc1_patch_stress = vol_n_mc1_patch.copy()
        mc1_mesh_stress = vol_n_mc1_mesh.copy()

        mc1_mesh_stress.transform(tfm, inplace = True)
        mc1_patch_stress.transform(tfm, inplace = True)

        # assign JSW and Stress values to respective patches
        mc1_patch_jsw['jsw'] = mc1_jsw
        trp_patch['stress'] = trp_jsw
        mc1_patch_stress['stress'] = stress

        all_mc1_jsw_meshes.append(mc1_mesh)
        all_mc1_stress_meshes.append(mc1_mesh_stress)
        all_mc1_jsw_patches.append(mc1_patch_jsw)
        all_mc1_stress_patches.append(mc1_patch_stress)
        all_trp_meshes.append(trp_mesh)
        all_trp_patches.append(trp_patch)

        # calculate magnitude of displacement of center of MC1 with reference to reference mesh frame
        disp = tuple(ai - bi for ai, bi in zip(initial_center, mc1_mesh.center))
        disp_mag = np.sqrt(disp[0]**2 + disp[1]**2 + disp[2]**2)

        displacements.append(disp_mag)
    
    forces_df['displacement'] = displacements
    forces_df['normalized_magnitude'] = (forces_df['magnitude'] - forces_df['magnitude'].min()) / (forces_df['magnitude'].max() - forces_df['magnitude'].min())
    forces_df['normalized_displacement'] = (forces_df['displacement'] - forces_df['displacement'].min()) / (forces_df['displacement'].max() - forces_df['displacement'].min())

    normalized_forces_df = forces_df.copy()
    normalized_forces_df.drop(columns=['Fx', 'Fy', 'Fz', 4, 5, 6], inplace=True)
    new_forces_filename = os.path.join(dynact_path, f'{subject}_{motion}_forces_and_displacements.xlsx')
    normalized_forces_df.to_excel(new_forces_filename, index=False)

    print('Processing Images...')
    mat_vol = 6
    # for ease of viewing, try to align bones along x-axis
    _, jsw_matrix = all_mc1_jsw_meshes[mat_vol+1].align_xyz(return_matrix=True)
    for i in range(len(all_mc1_jsw_meshes)):
        all_mc1_jsw_meshes[i].transform(jsw_matrix, inplace=True)
        all_mc1_jsw_patches[i].transform(jsw_matrix, inplace=True)
        all_trp_meshes[i].transform(jsw_matrix, inplace=True)
        all_trp_patches[i].transform(jsw_matrix, inplace=True)
        all_mc1_stress_meshes[i].transform(jsw_matrix, inplace=True)
        all_mc1_stress_patches[i].transform(jsw_matrix, inplace=True)

    # calculating reference values for clim_stress
    mean_stress = np.mean(all_stress_values)
    std_stress = np.std(all_stress_values)
    clim_2_upper = mean_stress + 2 * std_stress
    print(f"\tAverage Stress: {mean_stress}")
    print(f"\tStd Deviation: {std_stress}")
    print(f"\tUpper Colour Limit: {clim_2_upper}")

    print(f"Generating images...")

    # assigning plot parameters for each motion
    jsw_normal = compute_normal_vector(all_mc1_jsw_meshes[0], all_mc1_jsw_patches[0])
    stress_normal = compute_normal_vector(all_mc1_stress_meshes[0], all_mc1_stress_patches[0])
    views = ['yz', 'yz']
    offsets = ['-x','+x', '-x']
    if jsw_normal[0] < 0:
        offsets[0] = '-x' # mc1
        offsets[1] = '+x' # trp
    else:
        offsets[0] = '+x' # mc1
        offsets[1] = '-x' # trp
    
    if stress_normal[0] < 0:
        offsets[2] = '-x' # mc1
    else:
        offsets[2] = '+x' # mc1

    # function to create the bone mesh plot
    plot_bones(
        all_mc1_stress_meshes, 
        all_trp_meshes, 
        all_mc1_jsw_meshes,
        all_mc1_stress_patches,
        all_trp_patches,
        all_mc1_jsw_patches,
        scalar_names=['stress', 'stress', 'jsw'],
        cmaps=['turbo', 'turbo', 'turbo_r'],
        clim_12=[0,clim_2_upper],
        clim_3=[0, 4],
        views=views,
        offsets=offsets,
        plot=False,
        output_dir=dynact_path,
        gif_filename=f"{subject}_{motion}_stress.gif"
    )

    # function to plot bone forces and displacement over time
    plot_forces(
        forces_df, 
        displacements, 
        output_dir=dynact_path, 
        filename=f"{subject}_{motion}_forces.png"
    )