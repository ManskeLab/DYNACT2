# ----------------------------------------------------------------
# tmc_dea_preprocess.py 
#
# Created by: Chris Brunet
# Created on: June 19, 2025
#
# Preprocesses registered bone masks from TMC joint for use in MATLAB DEA program
#
# Usage: 
#     1. Follow instructions in readme.md
#     2. Run command: 
# 'python tmc_dea_preprocess.py {file_path_to_dynact_subjects} {subject_no} -m {motion} -mat {volume_for_tfm}'
# ----------------------------------------------------------------

import os
import argparse
import sys
import pyvista as pv
import numpy as np
import pandas as pd
import SimpleITK as sitk
import vtk

from mesh_utils import generate_mesh, jsm_raytrace, compute_normal_vector, compute_alignment_matrix
from plot_utils import plot_bones

vtk.vtkObject.GlobalWarningDisplayOff()

def check_path(path, mkdir=False):
  """
  Exits script if path does not exist

  """
  path_short = path.split("/")[-1]

  if os.path.exists(path):
    print(f"\t{path_short} Exists")
  else:
    if mkdir:
      print(f"\t{path_short} Does Not Exist. Creating path...")
      os.mkdir(path)
    else:
      print(f"\t{path_short} Does Not Exist. Exiting...")
      sys.exit()

def get_mesh(output_path, mask_path, bone):
  """
  Logic to determine if mesh needs to be generated from a mask or if the file already exists

  Args:
    output_path (string): path where mesh is saved
    mask_path (string): pather where bone mask is saved
    bone (string): used for printing

  Returns:
    mesh (pyvista.PolyData): surface mesh of the desired bone 
  """
  if os.path.exists(output_path):
    print(f"\t{bone} Mesh Already Exists")
    mesh = pv.read(output_path)
  else:
    print(f"\tGenerating New Mesh for {bone}")
    mesh = generate_mesh(mask_path)
    mesh.save(output_path)
  return mesh

def save_jsw(transformed_mesh, output_path):
  """
  Processes joint space mesh for saving points and joint space width to excel file

  Args:
    transformed_mesh (pyvista.PolyData): mesh with JSW values to be saved
    output_path (string): path to save excel file
  """
  jsw_list = list(transformed_mesh['distance'])

  cell_centers = transformed_mesh.cell_centers().points
  data_to_export = []
  for i in range(len(cell_centers)):
    data_to_export.append(list(cell_centers[i]) + [jsw_list[i]])

  df = pd.DataFrame(data_to_export, columns=['x', 'y', 'z', 'jsw'])
  df.to_excel(output_path, index=False)

def get_jsm(mesh_output_path, xlsx_output_path, source_mesh, target_mesh, source_bone, target_bone):
  """
  Logic to determine if a joint space mesh needs to be generated or if file already exists

  Args:
    mesh_output_path (string): path where mesh is saved
    xlsx_output_path (string): path where excel file of joint space width is saved
    volume_path (string): path where original grayscale image is found
    source_mesh (pyvista.PolyData): surface mesh of source bone (casting rays)
    target_mesh (pyvista.PolyData): surface mesh of target bone (receiving rays)
    source_bone (string): bone name used for printing
    target_bone (string): bone name used for printing

  Returns:
    tuple: A tuple containing:
      - jsm (pyvista.PolyData): surface mesh of articular surface of the source mesh
      - jsw (list): list of joint space width values
  """
  if os.path.exists(mesh_output_path) and os.path.exists(xlsx_output_path) :
    print(f"\t\t{source_bone} Patch and Excel File Already Exists")
    jsm = pv.read(mesh_output_path)
    jsw_df = pd.read_excel(xlsx_output_path)
    jsw = jsw_df['jsw'].values

  else:
    print(f"\t\tCalculating JSW for {source_bone} -> {target_bone}")
    jsm, jsw, _ = jsm_raytrace(source_mesh, target_mesh, 7)

  return jsm, jsw

# Parse input args
parser = argparse.ArgumentParser()
parser.add_argument("dynact_path", type = str, help = "Base file path for all dynact subjects")
parser.add_argument("subject", type = str, help = "Subject number")
parser.add_argument("-m", type = str, default=None, help = "Motion to to preprocess")
parser.add_argument("-mat", type = str, default=None, help = "Transformation matrix to use")
args = parser.parse_args()
dynact_path = args.dynact_path
subject = args.subject
motion = args.m

# Handle input arg values
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

check_path(dynact_path)

# loop through motions
for motion in motions:
  print(f"\nSTARTING DYNACT2_{subject}_{motion}")

  # base file paths
  base_path = os.path.join(dynact_path, f"DYNACT2_{subject}/DYNACT2_{subject}_{motion}")
  volumes_path = os.path.join(base_path, "RESAMPLED")
  registered_masks_path = os.path.join(base_path, "REGISTRATION/RegisteredMasks")
  check_path(base_path)
  check_path(volumes_path)
  check_path(registered_masks_path)

  # wbct files paths used for frame 1
  mc1_wbct_seg_path = os.path.join(dynact_path, f"DYNACT2_{subject}/DYNACT2_{subject}_WBCT/DYNACT2_{subject}_WBCT_CROP_PERI_MC1_BB_REORIENT_{motion}_TRANSF.nii")
  trp_wbct_seg_path = os.path.join(dynact_path, f"DYNACT2_{subject}/DYNACT2_{subject}_WBCT/DYNACT2_{subject}_WBCT_CROP_PERI_TRP_BB_REORIENT_{motion}_TRANSF.nii")
  if not os.path.exists(mc1_wbct_seg_path):
    continue

  # checking number of volumes and masks
  volumes = [item for item in os.listdir(volumes_path) if not item.startswith(".")]
  registered_masks = [item for item in os.listdir(registered_masks_path) if not item.startswith(".")]
  print(f"\tNumber of volumes: {len(volumes)}")
  print(f"\tNumber of registered masks: {len(registered_masks)}")

  # checking or creating output folders
  dea_path = os.path.join(base_path, "DEA FILES")
  output_path = os.path.join(dea_path, "Outputs")
  original_meshes_path = os.path.join(dea_path, "Original Meshes")
  ref_mesh_tfms_path = os.path.join(output_path, 'Reference Mesh Transforms')
  check_path(dea_path, mkdir=True)
  check_path(output_path, mkdir=True)
  check_path(original_meshes_path, mkdir=True)
  check_path(ref_mesh_tfms_path, mkdir=True)

  all_mc1_patches = []
  all_trp_patches = []
  all_mc1_meshes = []
  all_trp_meshes = []
  max_mc1_jsw = 0
  max_jsw_index = 0

  #### GETTING ALL ORIGINAL MESHES ####
  for i in range(len(volumes)):
    volume = i + 1
    print(f"VOLUME {volume}:")

    # input file names      
    mc1_mask_path = os.path.join(registered_masks_path, f"VOLUME_1_TO_{volume}_MC1_MASK_REG.nii")
    trp_mask_path = os.path.join(registered_masks_path, f"VOLUME_1_TO_{volume}_TRP_MASK_REG.nii")

    # output file names
    original_mc1_mesh_output = os.path.join(original_meshes_path, f"VOLUME_{volume}_MC1_MESH_ORIGINAL.stl")
    original_trp_mesh_output = os.path.join(original_meshes_path, f"VOLUME_{volume}_TRP_MESH_ORIGINAL.stl")
    mc1_mesh_output = os.path.join(output_path, f"VOLUME_{volume}_MC1_MESH.stl")
    trp_mesh_output = os.path.join(output_path, f"VOLUME_{volume}_TRP_MESH.stl")
    mc1_patch_output = os.path.join(output_path, f"VOLUME_{volume}_MC1_PATCH.stl")
    trp_patch_output = os.path.join(output_path, f"VOLUME_{volume}_TRP_PATCH.stl")
    mc1_jsw_output = os.path.join(output_path, f"VOLUME_{volume}_MC1_PATCH_JSW.xlsx")
    trp_jsw_output = os.path.join(output_path, f"VOLUME_{volume}_TRP_PATCH_JSW.xlsx")
    
    if volume == 1:
      mc1_mask_path = mc1_wbct_seg_path
      trp_mask_path = trp_wbct_seg_path

      # for wbct images, we have to resample to the size of the rest of the masks in the series
      wbct_mc1_mask = sitk.ReadImage(mc1_mask_path)
      wbct_trp_mask = sitk.ReadImage(trp_mask_path)
      mc1_ref_img = sitk.ReadImage(os.path.join(registered_masks_path, f"VOLUME_1_TO_2_MC1_MASK_REG.nii"))
      trp_ref_img = sitk.ReadImage(os.path.join(registered_masks_path, f"VOLUME_1_TO_2_TRP_MASK_REG.nii"))

      print("\tResampling WBCT Images")
      print(f"\t\tMC1 Original size: {mc1_ref_img.GetSize()}")
      print(f"\t\tTRP Original size: {trp_ref_img.GetSize()}")

      wbct_mc1_mask_resampled = sitk.Resample(image1=wbct_mc1_mask, referenceImage=mc1_ref_img)
      wbct_trp_mask_resampled = sitk.Resample(image1=wbct_trp_mask, referenceImage=trp_ref_img)

      print(f"\t\tMC1 Resampled size: {wbct_mc1_mask_resampled.GetSize()}")
      print(f"\t\tTRP Resampled size: {wbct_trp_mask_resampled.GetSize()}")

      sitk.WriteImage(wbct_mc1_mask_resampled, mc1_mask_path)
      sitk.WriteImage(wbct_trp_mask_resampled, trp_mask_path)

    # this function checks if the original mesh exists and creates a new one if not
    mc1_mesh = get_mesh(original_mc1_mesh_output, mc1_mask_path, 'MC1')
    trp_mesh = get_mesh(original_trp_mesh_output, trp_mask_path, 'TRP')
    all_mc1_meshes.append(mc1_mesh)
    all_trp_meshes.append(trp_mesh)

    # save mesh to "Non-Transformed" folder
    print("\tSaving Mesh Copies to Outputs folder")
    mc1_mesh.save(mc1_mesh_output)
    trp_mesh.save(trp_mesh_output)

    #### CALCULATING JSW, SAVING PATCHES ####
    print(f"\tComputing JSW for Volume {volume}")
    # this function checks if JSM and JSW files already exist and generates new ones if not
    mc1_jsm, mc1_jsw = get_jsm(mc1_patch_output, mc1_jsw_output, all_mc1_meshes[i], all_trp_meshes[i], "MC1", "TRP")
    trp_jsm, trp_jsw = get_jsm(trp_patch_output, trp_jsw_output, all_trp_meshes[i], all_mc1_meshes[i], "TRP", "MC1")

    # for DEA, we want to use the largest JSW frame as the reference 
    # frame and then compute all stresses generated by movements relative to that frame
    if np.mean(mc1_jsw) > max_mc1_jsw and np.mean(mc1_jsw) < 3: # add upper limit to remove outliers
      max_mc1_jsw = np.mean(mc1_jsw)
      max_jsw_index = i

    # assign JSW values to meshes
    mc1_jsm['distance'] = mc1_jsw
    trp_jsm['distance'] = trp_jsw
    all_mc1_patches.append(mc1_jsm)
    all_trp_patches.append(trp_jsm)

    # save meshes and patches
    if os.path.exists(mc1_patch_output):
      print("\tJSWs and Patches Already Saved")
    else:
      print("\tSaving Joint Space Mesh Patch")
      mc1_jsm.save(mc1_patch_output)
      trp_jsm.save(trp_patch_output)
      print("\tSaving Joint Space Width Excel Files")
      save_jsw(all_mc1_patches[i], mc1_jsw_output)
      save_jsw(all_trp_patches[i], trp_jsw_output)  

  print(f"\nCALCULATING NORMAL VECTOR FROM MC1 VOLUME {max_jsw_index+1}")
  # for DEA we need to make sure the bones are "just" touching
  # so we compute the normal vector of MC1 and the Average JSW from
  # the reference frame and use that as an initial transformation 
  normal_vector = compute_normal_vector(all_mc1_meshes[max_jsw_index], all_mc1_patches[max_jsw_index])
  print(f"\tMax JSW Index: {max_jsw_index}")
  print(f"\tAvg JSW: {max_mc1_jsw}")
  print(f"\tNormal Vector: {normal_vector}")
  normal_vector_and_jsw = np.append(normal_vector, [max_jsw_index, max_mc1_jsw])
  normal_vector_output = os.path.join(output_path, "normal_vector.csv")
  np.savetxt(normal_vector_output, normal_vector_and_jsw, fmt="%.8f", delimiter=",")

  print(f"\nCOMPUTING TRANSFORM RELATIVE TO REFERANCE MESH")
  for i in range(len(all_mc1_meshes)):
    print(f"\tFinding MC1 Transform for frame: {max_jsw_index+1} to {i+1}")
    mc1_tfm_output = os.path.join(ref_mesh_tfms_path, f"VOL_{max_jsw_index+1}_TO_{i+1}_MC1_TFM.csv")
    if os.path.exists(mc1_tfm_output):
      print("\t\tTransform Already Exists")
    else:
      mc1_tfm = compute_alignment_matrix(all_mc1_meshes[max_jsw_index], all_mc1_meshes[i])
      np.savetxt(mc1_tfm_output, mc1_tfm, fmt="%.8f", delimiter=",")

    print(f"\tFinding TRP Transform for frame: {max_jsw_index+1} to {i+1}")
    trp_tfm_output = os.path.join(ref_mesh_tfms_path, f"VOL_{max_jsw_index+1}_TO_{i+1}_TRP_TFM.csv")
    if os.path.exists(trp_tfm_output):
      print("\t\tTransform Already Exists")
    else:
      trp_tfm = compute_alignment_matrix(all_trp_meshes[max_jsw_index], all_trp_meshes[i])
      np.savetxt(trp_tfm_output, trp_tfm, fmt="%.8f", delimiter=",")

  print("\nGENERATING PLOTS")
  # align meshes to x-axis for ease of plotting
  mat_vol = 6
  _, jsw_matrix = all_mc1_meshes[mat_vol+1].align_xyz(return_matrix=True)
  for i in range(len(all_mc1_meshes)):
      all_mc1_meshes[i].transform(jsw_matrix, inplace=True)
      all_mc1_patches[i].transform(jsw_matrix, inplace=True)
      all_trp_meshes[i].transform(jsw_matrix, inplace=True)
      all_trp_patches[i].transform(jsw_matrix, inplace=True)
  
  # assigning plot parameters for each motion
  aligned_normal_vector = compute_normal_vector(all_mc1_meshes[0], all_mc1_patches[0])
  views = ['yz', 'yz']
  if aligned_normal_vector[0] < 0:
      offsets = ['-x','+x', '+x']
  else:
      offsets = ['+x','-x', '-x']

  # function to create the plot
  plot_bones(
      all_mc1_meshes, 
      all_trp_meshes, 
      all_trp_meshes,
      all_mc1_patches,
      all_trp_patches,
      all_trp_patches,
      scalar_names=['distance', 'distance', 'distance'],
      cmaps=['turbo_r', 'turbo_r', 'turbo_r'],
      clim_12=[0,4],
      clim_3=[0,4],
      views=views,
      offsets=offsets,
      plot=False,
      output_dir=dea_path,
      gif_filename=f"{subject}_{motion}_tmc_joint.gif"
  )
