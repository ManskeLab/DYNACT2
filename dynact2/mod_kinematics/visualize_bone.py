"""
  Plots (pyvista) a visualization of a bone surface, joint surface and/or coordinate system (bonemask and js_mask can
  be either .nii or .vtk files)

  Usage: python visualize_bone.py --bonemask=bone_mask_path --js_mask=joint_surface_path --jcs=jcs_csv

  Last Modified: Sept 2025, Erica Baldesarra
  
  """

import argparse
import os
import SimpleITK as sitk
import numpy as np
import pandas as pd
import pyvista as pv
from tmc_jcs_utils import sitk_to_pyvista_surface

def create_pyvista_image_mesh(image_path):
  if ".vtk" in image_path.lower():
    return pv.read(image_path)
  elif ".nii" in image_path.lower() or "nii.gz" in image_path.lower():
    image = sitk.ReadImage(image_path)
    return sitk_to_pyvista_surface(image)

def plot_bone(bone_image, plotter):
  plotter.add_mesh(bone_image, color="white", opacity=0.3, label="Bone Surface")

def plot_joint_surface(joint_mesh, plotter):
  plotter.add_mesh(joint_mesh, colour='yellow', opacity=0.4, label="Joint Surface")

def plot_jcs_vector(saddle, x_axis, y_axis, z_axis, plotter):
  plotter.add_mesh(
      pv.Sphere(radius=0.5, center=saddle), color="red", label="Saddle Point"
  )
  plotter.add_mesh(
      pv.Arrow(start=saddle, direction=x_axis, scale=5.0),
      color="orange",
      label="X",
  )
  plotter.add_mesh(
      pv.Arrow(start=saddle, direction=y_axis, scale=5.0),
      color="purple",
      label="Y",
  )
  plotter.add_mesh(
      pv.Arrow(start=saddle, direction=z_axis, scale=5.0),
      color="green",
      label="Z",
  )

def plot_jcs(jcs, plotter):
  saddle = jcs[0]
  x_axis = jcs[1]
  y_axis = jcs[2]
  z_axis = jcs[3]
  plot_jcs_vector(saddle, x_axis, y_axis, z_axis, plotter)

if __name__ == "__main__":
  parser = argparse.ArgumentParser(
      description="Visualize bone/joint surfaces and/or coordinate system"
  )
  parser.add_argument("--bonemask", help="Path to bone", action='append', default=None)
  parser.add_argument("--js_mask", help="Path to joint surface", action='append', default=None)
  parser.add_argument("--jcs", help="Path to jcs csv", action='append', default=None)
  
  args = parser.parse_args()
  plotter = pv.Plotter()

  if args.bonemask is not None:
    for bone in args.bonemask:
      bone_image = create_pyvista_image_mesh(bone)
      plot_bone(bone_image, plotter)
  
  if args.js_mask is not None:
    for js in args.js_mask:
      js_image = create_pyvista_image_mesh(js)
      plot_bone(js_image, plotter)

  if args.jcs is not None:
    for jcs in args.jcs:
      with open(jcs, 'r') as f:
        bone_scs = pd.read_csv(f, usecols = [1, 2, 3]).values
        plot_jcs(bone_scs, plotter)

  plotter.add_legend()
  plotter.show()