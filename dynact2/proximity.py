import re
import os
import sys
import vtk
import time
import argparse
import numpy as np
import pyvista as pv
import pymeshfix as mf
import matplotlib.pyplot as plt

from pyacvd import Clustering
from scipy.spatial import KDTree
from matplotlib.colors import ListedColormap

from image_to_polydata import image_to_polydata

def compute_proximity(surface_1, surface_2, basename, frame, q):
    # Compute proximity using KD-TREE
    print("Computing proximity...", flush=True)

    # MC1
    tree = KDTree(surface_1.points)
    d, idx = tree.query(surface_2.points)
    surface_2["Proximity"] = d

    contact = surface_2.threshold(value=(0, 3.0), scalars="Proximity").extract_surface()

    contact_path = os.path.join(dynact_reg_mask_dir, basename + "_CONTACT.vtk")
    contact.save(contact_path)
    smooth_path = os.path.join(dynact_reg_mask_dir, basename + "_SMOOTH.vtk")
    surface_2.save(smooth_path)

    contact_true = surface_2.threshold(value=(0, 1.5), scalars="Proximity").extract_surface()
    contact_ture_path = os.path.join(dynact_reg_mask_dir, basename + "_CONTACT_TRUE.vtk")
    contact_true.save(contact_ture_path)
    
    # Need to dilate masks to capture all contact that occurs in each quad
    # extrude = vtk.vtkLinearExtrusionFilter()
    # extrude.SetInputData(q[0])
    # extrude.SetVector(2, 0, -2)
    # extrude.Update()
    # extruded_mesh = pv.wrap(extrude.GetOutput())

    q1_js = contact_true.clip_surface(q[0], invert=True)
    q1_js.save(os.path.join(dynact_reg_mask_dir, basename + "_CONTACT_TRUE_Q1.vtk"))
    q2_js = contact_true.clip_surface(q[1], invert=True)
    q2_js.save(os.path.join(dynact_reg_mask_dir, basename + "_CONTACT_TRUE_Q2.vtk"))
    q3_js = contact_true.clip_surface(q[2], invert=True)
    q3_js.save(os.path.join(dynact_reg_mask_dir, basename + "_CONTACT_TRUE_Q3.vtk"))
    q4_js = contact_true.clip_surface(q[3], invert=True)
    q4_js.save(os.path.join(dynact_reg_mask_dir, basename + "_CONTACT_TRUE_Q4.vtk"))

    if contact_true.area <= 0:
        print("Error: no contact between bones. Skipping frame {}".format(frame), flush=True)
        return (0, [0,0,0], [0,0,0,0])
    
    area = contact_true.area
    com = contact_true.center_of_mass(scalars_weight=True)

    area_q1 = q1_js.area
    area_q2 = q2_js.area
    area_q3 = q3_js.area
    area_q4 = q4_js.area

    q_area = [area_q1, area_q2, area_q3, area_q4]

    return (area, com, q_area)



def main(wbct_mask_dir, dynact_reg_mask_dir, output_path):
    # Convert all registered masks to VTK PolyData
    # output_polydata_dir = os.path.dirname(dynact_reg_mask_dir)

    # Get the list of registered masks, split into TRP and MC1 lists
    mask_files = os.listdir(dynact_reg_mask_dir)
    mask_files = [f for f in mask_files if "MASK_REG" in f]

    mc1_mask_files = [m for m in mask_files if "MC1_MASK_REG.nii" in m]
    mc1_q1_mask_files = [t for t in mask_files if "MC1_MASK_REG_Q1.nii" in t]
    mc1_q2_mask_files = [t for t in mask_files if "MC1_MASK_REG_Q2.nii" in t]
    mc1_q3_mask_files = [t for t in mask_files if "MC1_MASK_REG_Q3.nii" in t]
    mc1_q4_mask_files = [t for t in mask_files if "MC1_MASK_REG_Q4.nii" in t]
    # trp_mask_files = [t for t in mask_files if "TRP_MASK_REG.nii" in t]

    # Output CSV of contact areas
    header_arr = np.array(["Frame", 
                           "MC1 Area (mm^2)", 
                           "MC1 Area Q1 (mm^2)", "MC1 Area Q2 (mm^2)", "MC1 Area Q3 (mm^2)", "MC1 Area Q4 (mm^2)",
                           "TRP Area (mm^2)", 
                           "TRP Area Q1 (mm^2)", "TRP Area Q2 (mm^2)", "TRP Area Q3 (mm^2)", "TRP Area Q4 (mm^2)",
                           "MC1 Area Centroid X", "MC1 Area Centroid Y", "MC1 Area Centroid Z",
                           "TRP Area Centroid X", "TRP Area Centroid Y", "TRP Area Centroid Z"])
    output_arr = header_arr

    study_id = wbct_mask_dir.split(str("/"))[-1][:-5]
    movement = dynact_reg_mask_dir.split(str("/"))[-3][12:]

    # Get the first frame contact
    print("Processing Frame 1", flush=True)
    frame_1_mc1_mask = os.path.join(wbct_mask_dir, study_id + "_WBCT_CROP_PERI_MC1_BB_REORIENT_" + movement + "_TRANSF.nii")
    frame_1_mc1_q1 = os.path.join(wbct_mask_dir, study_id + "_WBCT_CROP_PERI_MC1_BB_REORIENT_" + movement + "_TRANSF_Q1.nii")
    frame_1_mc1_q2 = os.path.join(wbct_mask_dir, study_id + "_WBCT_CROP_PERI_MC1_BB_REORIENT_" + movement + "_TRANSF_Q2.nii")
    frame_1_mc1_q3 = os.path.join(wbct_mask_dir, study_id + "_WBCT_CROP_PERI_MC1_BB_REORIENT_" + movement + "_TRANSF_Q3.nii")
    frame_1_mc1_q4 = os.path.join(wbct_mask_dir, study_id + "_WBCT_CROP_PERI_MC1_BB_REORIENT_" + movement + "_TRANSF_Q4.nii")
    frame_1_trp_mask = os.path.join(wbct_mask_dir, study_id + "_WBCT_CROP_PERI_TRP_BB_REORIENT_" + movement + "_TRANSF.nii")
    frame_1_trp_q1 = os.path.join(wbct_mask_dir, study_id + "_WBCT_CROP_PERI_TRP_BB_REORIENT_" + movement + "_TRANSF_Q1.nii")
    frame_1_trp_q2 = os.path.join(wbct_mask_dir, study_id + "_WBCT_CROP_PERI_TRP_BB_REORIENT_" + movement + "_TRANSF_Q2.nii")
    frame_1_trp_q3 = os.path.join(wbct_mask_dir, study_id + "_WBCT_CROP_PERI_TRP_BB_REORIENT_" + movement + "_TRANSF_Q3.nii")
    frame_1_trp_q4 = os.path.join(wbct_mask_dir, study_id + "_WBCT_CROP_PERI_TRP_BB_REORIENT_" + movement + "_TRANSF_Q4.nii")

    print("Converting {} to PolyData...".format(frame_1_mc1_mask), flush=True)
    print("Converting {} to PolyData...".format(frame_1_trp_mask), flush=True)
    mc1_1_basename = os.path.splitext(os.path.basename(frame_1_mc1_mask))[0]
    trp_1_basename = os.path.splitext(os.path.basename(frame_1_trp_mask))[0]
    image_to_polydata(frame_1_mc1_mask, os.path.join(wbct_mask_dir, mc1_1_basename + ".vtk"))
    image_to_polydata(frame_1_mc1_q1, os.path.join(wbct_mask_dir, mc1_1_basename + "_Q1.vtk"))
    image_to_polydata(frame_1_mc1_q2, os.path.join(wbct_mask_dir, mc1_1_basename + "_Q2.vtk"))
    image_to_polydata(frame_1_mc1_q3, os.path.join(wbct_mask_dir, mc1_1_basename + "_Q3.vtk"))
    image_to_polydata(frame_1_mc1_q4, os.path.join(wbct_mask_dir, mc1_1_basename + "_Q4.vtk"))
    image_to_polydata(frame_1_trp_mask, os.path.join(wbct_mask_dir, trp_1_basename + ".vtk"))
    image_to_polydata(frame_1_trp_q1, os.path.join(wbct_mask_dir, trp_1_basename + "_Q1.vtk"))
    image_to_polydata(frame_1_trp_q2, os.path.join(wbct_mask_dir, trp_1_basename + "_Q2.vtk"))
    image_to_polydata(frame_1_trp_q3, os.path.join(wbct_mask_dir, trp_1_basename + "_Q3.vtk"))
    image_to_polydata(frame_1_trp_q4, os.path.join(wbct_mask_dir, trp_1_basename + "_Q4.vtk"))

    # Read in as a PyVista mesh
    mc1_mesh = pv.read(os.path.join(wbct_mask_dir, mc1_1_basename + ".vtk"))
    mc1_q1_mesh = pv.read(os.path.join(wbct_mask_dir, mc1_1_basename + "_Q1.vtk"))
    mc1_q2_mesh = pv.read(os.path.join(wbct_mask_dir, mc1_1_basename + "_Q2.vtk"))
    mc1_q3_mesh = pv.read(os.path.join(wbct_mask_dir, mc1_1_basename + "_Q3.vtk"))
    mc1_q4_mesh = pv.read(os.path.join(wbct_mask_dir, mc1_1_basename + "_Q4.vtk"))
    trp_mesh = pv.read(os.path.join(wbct_mask_dir, trp_1_basename + ".vtk"))
    trp_q1_mesh = pv.read(os.path.join(wbct_mask_dir, trp_1_basename + "_Q1.vtk"))
    trp_q2_mesh = pv.read(os.path.join(wbct_mask_dir, trp_1_basename + "_Q2.vtk"))
    trp_q3_mesh = pv.read(os.path.join(wbct_mask_dir, trp_1_basename + "_Q3.vtk"))
    trp_q4_mesh = pv.read(os.path.join(wbct_mask_dir, trp_1_basename + "_Q4.vtk"))

    mc1_mesh = mc1_mesh.clean()
    trp_mesh = trp_mesh.clean()
    mc1_q1_mesh = mc1_q1_mesh.clean()
    mc1_q2_mesh = mc1_q2_mesh.clean()
    mc1_q3_mesh = mc1_q3_mesh.clean()
    mc1_q4_mesh = mc1_q4_mesh.clean()
    trp_q1_mesh = trp_q1_mesh.clean()
    trp_q2_mesh = trp_q2_mesh.clean()
    trp_q3_mesh = trp_q3_mesh.clean()
    trp_q4_mesh = trp_q4_mesh.clean()

    mc1_mesh = mc1_mesh.smooth(n_iter=200)
    trp_mesh = trp_mesh.smooth(n_iter=200)
    mc1_q1_mesh = mc1_q1_mesh.smooth(n_iter=200)
    mc1_q2_mesh = mc1_q2_mesh.smooth(n_iter=200)
    mc1_q3_mesh = mc1_q3_mesh.smooth(n_iter=200)
    mc1_q4_mesh = mc1_q4_mesh.smooth(n_iter=200)
    trp_q1_mesh = trp_q1_mesh.smooth(n_iter=200)
    trp_q2_mesh = trp_q2_mesh.smooth(n_iter=200)
    trp_q3_mesh = trp_q3_mesh.smooth(n_iter=200)
    trp_q4_mesh = trp_q4_mesh.smooth(n_iter=200)

    # Resampling meshes to have uniform polygons using voronoi clustering
    cluster_mc1 = Clustering(mc1_mesh)
    cluster_mc1.subdivide(2)
    cluster_mc1.cluster(10000)
    remesh_mc1 = cluster_mc1.create_mesh()

    cluster_trp = Clustering(trp_mesh)
    cluster_trp.subdivide(2)
    cluster_trp.cluster(10000)
    remesh_trp = cluster_trp.create_mesh()

    cluster_mc1_q1 = Clustering(mc1_q1_mesh)
    cluster_mc1_q1.subdivide(2)
    cluster_mc1_q1.cluster(10000)
    mc1_q1_mesh = cluster_mc1_q1.create_mesh()
    cluster_mc1_q2 = Clustering(mc1_q2_mesh)
    cluster_mc1_q2.subdivide(2)
    cluster_mc1_q2.cluster(10000)
    mc1_q2_mesh = cluster_mc1_q2.create_mesh()
    cluster_mc1_q3 = Clustering(mc1_q3_mesh)
    cluster_mc1_q3.subdivide(2)
    cluster_mc1_q3.cluster(10000)
    mc1_q3_mesh = cluster_mc1_q3.create_mesh()
    cluster_mc1_q4 = Clustering(mc1_q4_mesh)
    cluster_mc1_q4.subdivide(2)
    cluster_mc1_q4.cluster(10000)
    mc1_q4_mesh = cluster_mc1_q4.create_mesh()

    cluster_trp_q1 = Clustering(trp_q1_mesh)
    cluster_trp_q1.subdivide(2)
    cluster_trp_q1.cluster(10000)
    trp_q1_mesh = cluster_trp_q1.create_mesh()
    cluster_trp_q2 = Clustering(trp_q2_mesh)
    cluster_trp_q2.subdivide(2)
    cluster_trp_q2.cluster(10000)
    trp_q2_mesh = cluster_trp_q2.create_mesh()
    cluster_trp_q3 = Clustering(trp_q3_mesh)
    cluster_trp_q3.subdivide(2)
    cluster_trp_q3.cluster(10000)
    trp_q3_mesh = cluster_trp_q3.create_mesh()
    cluster_trp_q4 = Clustering(trp_q4_mesh)
    cluster_trp_q4.subdivide(2)
    cluster_trp_q4.cluster(10000)
    trp_q4_mesh = cluster_trp_q4.create_mesh()

    # Mesh smoothing
    smooth_mc1 = remesh_mc1.smooth(n_iter=500)
    smooth_trp = remesh_trp.smooth(n_iter=500)
    mc1_q1_mesh = mc1_q1_mesh.smooth(n_iter=500)
    mc1_q2_mesh = mc1_q2_mesh.smooth(n_iter=500)
    mc1_q3_mesh = mc1_q3_mesh.smooth(n_iter=500)
    mc1_q4_mesh = mc1_q4_mesh.smooth(n_iter=500)
    trp_q1_mesh = trp_q1_mesh.smooth(n_iter=500)
    trp_q2_mesh = trp_q2_mesh.smooth(n_iter=500)
    trp_q3_mesh = trp_q3_mesh.smooth(n_iter=500)
    trp_q4_mesh = trp_q4_mesh.smooth(n_iter=500)

    mc1_q = [mc1_q1_mesh, mc1_q2_mesh, mc1_q3_mesh, mc1_q4_mesh]
    trp_q = [trp_q1_mesh, trp_q2_mesh, trp_q3_mesh, trp_q4_mesh]

    (area_mc1, com_mc1, mc1_q_area) = compute_proximity(smooth_trp, smooth_mc1, mc1_1_basename, "1", mc1_q)
    (area_trp, com_trp, trp_q_area) = compute_proximity(smooth_mc1, smooth_trp, trp_1_basename, "1", trp_q)

    print("Contact Area MC1 = {} mm^2".format(area_mc1), flush=True)
    print("Contact Area MC1 Quads = {} mm^2".format(mc1_q_area), flush=True)
    print("Contact Area TRP = {} mm^2".format(area_trp), flush=True)
    print("Contact Area TRP Quads = {} mm^2".format(trp_q_area), flush=True)

    frame_arr = np.array([str(1), 
                          str(area_mc1), 
                          str(mc1_q_area[0]), str(mc1_q_area[1]), str(mc1_q_area[2]), str(mc1_q_area[3]),
                          str(area_trp), 
                          str(trp_q_area[0]), str(trp_q_area[1]), str(trp_q_area[2]), str(trp_q_area[3]),
                          str(com_mc1[0]), str(com_mc1[1]), str(com_mc1[2]),
                          str(com_trp[0]), str(com_trp[1]), str(com_trp[2])])
    output_arr = np.vstack((output_arr, frame_arr))
    print()
    

    # Loop through pairs of masks and compute proximity maps
    mc1_mask_files = sorted(mc1_mask_files, key=lambda s: int(re.search(r'\d+', s).group()))
    mc1_q1_mask_files = sorted(mc1_q1_mask_files, key=lambda s: int(re.search(r'\d+', s).group()))
    mc1_q2_mask_files = sorted(mc1_q2_mask_files, key=lambda s: int(re.search(r'\d+', s).group()))
    mc1_q3_mask_files = sorted(mc1_q3_mask_files, key=lambda s: int(re.search(r'\d+', s).group()))
    mc1_q4_mask_files = sorted(mc1_q4_mask_files, key=lambda s: int(re.search(r'\d+', s).group()))

    for i in range(0, len(mc1_mask_files), 1):
        frame = re.findall(r'\d+', mc1_mask_files[i])
        print(frame)
        frame_1 = int(frame[0])
        frame_2 = int(frame[1])
        if int(frame_1) > 26 or int(frame_2) > 26:
            continue

        print("Processing Frame {}".format(int(frame_2)), flush=True)
        mc1_mask_path = mc1_mask_files[i]
        trp_mask_path = mc1_mask_path.replace("MC1", "TRP")

        mc1_q1_mask_path = mc1_q1_mask_files[i]
        mc1_q2_mask_path = mc1_q2_mask_files[i]
        mc1_q3_mask_path = mc1_q3_mask_files[i]
        mc1_q4_mask_path = mc1_q4_mask_files[i]
        trp_q1_mask_path = mc1_q1_mask_path.replace("MC1", "TRP")
        trp_q2_mask_path = mc1_q2_mask_path.replace("MC1", "TRP")
        trp_q3_mask_path = mc1_q3_mask_path.replace("MC1", "TRP")
        trp_q4_mask_path = mc1_q4_mask_path.replace("MC1", "TRP")

        mc1_basename = os.path.splitext(os.path.basename(mc1_mask_path))[0]
        trp_basename = os.path.splitext(os.path.basename(trp_mask_path))[0]

        mc1_q1__basename = os.path.splitext(os.path.basename(mc1_q1_mask_path))[0]
        mc1_q2__basename = os.path.splitext(os.path.basename(mc1_q2_mask_path))[0]
        mc1_q3__basename = os.path.splitext(os.path.basename(mc1_q3_mask_path))[0]
        mc1_q4__basename = os.path.splitext(os.path.basename(mc1_q4_mask_path))[0]
        trp_q1__basename = os.path.splitext(os.path.basename(trp_q1_mask_path))[0]
        trp_q2__basename = os.path.splitext(os.path.basename(trp_q2_mask_path))[0]
        trp_q3__basename = os.path.splitext(os.path.basename(trp_q3_mask_path))[0]
        trp_q4__basename = os.path.splitext(os.path.basename(trp_q4_mask_path))[0]


        mc1_polydata_path = os.path.join(dynact_reg_mask_dir, mc1_basename + ".vtk")
        trp_polydata_path = os.path.join(dynact_reg_mask_dir, trp_basename + ".vtk")
        mc1_polydata_q1_path = os.path.join(dynact_reg_mask_dir, mc1_q1__basename + ".vtk")
        mc1_polydata_q2_path = os.path.join(dynact_reg_mask_dir, mc1_q2__basename + ".vtk")
        mc1_polydata_q3_path = os.path.join(dynact_reg_mask_dir, mc1_q3__basename + ".vtk")
        mc1_polydata_q4_path = os.path.join(dynact_reg_mask_dir, mc1_q4__basename + ".vtk")
        trp_polydata_q1_path = os.path.join(dynact_reg_mask_dir, trp_q1__basename + ".vtk")
        trp_polydata_q2_path = os.path.join(dynact_reg_mask_dir, trp_q2__basename + ".vtk")
        trp_polydata_q3_path = os.path.join(dynact_reg_mask_dir, trp_q3__basename + ".vtk")
        trp_polydata_q4_path = os.path.join(dynact_reg_mask_dir, trp_q4__basename + ".vtk")

        # Convert NIFTI files to PolyData
        print("Converting {} to PolyData...".format(mc1_mask_path), flush=True)
        print("Converting {} to PolyData...".format(trp_mask_path), flush=True)
        mc1_mask_path = os.path.join(dynact_reg_mask_dir, mc1_mask_path)
        trp_mask_path = os.path.join(dynact_reg_mask_dir, trp_mask_path)

        mc1_q1_mask_path = os.path.join(dynact_reg_mask_dir, mc1_q1_mask_path)
        mc1_q2_mask_path = os.path.join(dynact_reg_mask_dir, mc1_q2_mask_path)
        mc1_q3_mask_path = os.path.join(dynact_reg_mask_dir, mc1_q3_mask_path)
        mc1_q4_mask_path = os.path.join(dynact_reg_mask_dir, mc1_q4_mask_path)
        trp_q1_mask_path = os.path.join(dynact_reg_mask_dir, trp_q1_mask_path)
        trp_q2_mask_path = os.path.join(dynact_reg_mask_dir, trp_q2_mask_path)
        trp_q3_mask_path = os.path.join(dynact_reg_mask_dir, trp_q3_mask_path)
        trp_q4_mask_path = os.path.join(dynact_reg_mask_dir, trp_q4_mask_path)

        image_to_polydata(mc1_mask_path, mc1_polydata_path)
        image_to_polydata(trp_mask_path, trp_polydata_path)

        image_to_polydata(mc1_q1_mask_path, mc1_polydata_q1_path)
        image_to_polydata(mc1_q2_mask_path, mc1_polydata_q2_path)
        image_to_polydata(mc1_q3_mask_path, mc1_polydata_q3_path)
        image_to_polydata(mc1_q4_mask_path, mc1_polydata_q4_path)
        image_to_polydata(trp_q1_mask_path, trp_polydata_q1_path)
        image_to_polydata(trp_q2_mask_path, trp_polydata_q2_path)
        image_to_polydata(trp_q3_mask_path, trp_polydata_q3_path)
        image_to_polydata(trp_q4_mask_path, trp_polydata_q4_path)


        # Read in as a PyVista mesh
        mc1_mesh = pv.read(mc1_polydata_path)
        trp_mesh = pv.read(trp_polydata_path)

        mc1_q1_mesh = pv.read(mc1_polydata_q1_path)
        mc1_q2_mesh = pv.read(mc1_polydata_q2_path)
        mc1_q3_mesh = pv.read(mc1_polydata_q3_path)
        mc1_q4_mesh = pv.read(mc1_polydata_q4_path)
        trp_q1_mesh = pv.read(trp_polydata_q1_path)
        trp_q2_mesh = pv.read(trp_polydata_q2_path)
        trp_q3_mesh = pv.read(trp_polydata_q3_path)
        trp_q4_mesh = pv.read(trp_polydata_q4_path)


        mc1_mesh = mc1_mesh.clean()
        trp_mesh = trp_mesh.clean()
        mc1_q1_mesh = mc1_q1_mesh.clean()
        mc1_q2_mesh = mc1_q2_mesh.clean()
        mc1_q3_mesh = mc1_q3_mesh.clean()
        mc1_q4_mesh = mc1_q4_mesh.clean()
        trp_q1_mesh = trp_q1_mesh.clean()
        trp_q2_mesh = trp_q2_mesh.clean()
        trp_q3_mesh = trp_q3_mesh.clean()
        trp_q4_mesh = trp_q4_mesh.clean()


        mc1_mesh = mc1_mesh.smooth(n_iter=200)
        trp_mesh = trp_mesh.smooth(n_iter=200)
        mc1_q1_mesh = mc1_q1_mesh.smooth(n_iter=200)
        mc1_q2_mesh = mc1_q2_mesh.smooth(n_iter=200)
        mc1_q3_mesh = mc1_q3_mesh.smooth(n_iter=200)
        mc1_q4_mesh = mc1_q4_mesh.smooth(n_iter=200)
        trp_q1_mesh = trp_q1_mesh.smooth(n_iter=200)
        trp_q2_mesh = trp_q2_mesh.smooth(n_iter=200)
        trp_q3_mesh = trp_q3_mesh.smooth(n_iter=200)
        trp_q4_mesh = trp_q4_mesh.smooth(n_iter=200)

        # Resampling meshes to have uniform polygons using voronoi clustering
        cluster_mc1 = Clustering(mc1_mesh)
        cluster_mc1.subdivide(2)
        cluster_mc1.cluster(10000)
        remesh_mc1 = cluster_mc1.create_mesh()

        cluster_trp = Clustering(trp_mesh)
        cluster_trp.subdivide(2)
        cluster_trp.cluster(10000)
        remesh_trp = cluster_trp.create_mesh()

        cluster_mc1_q1 = Clustering(mc1_q1_mesh)
        cluster_mc1_q1.subdivide(2)
        cluster_mc1_q1.cluster(10000)
        mc1_q1_mesh = cluster_mc1_q1.create_mesh()
        cluster_mc1_q2 = Clustering(mc1_q2_mesh)
        cluster_mc1_q2.subdivide(2)
        cluster_mc1_q2.cluster(10000)
        mc1_q2_mesh = cluster_mc1_q2.create_mesh()
        cluster_mc1_q3 = Clustering(mc1_q3_mesh)
        cluster_mc1_q3.subdivide(2)
        cluster_mc1_q3.cluster(10000)
        mc1_q3_mesh = cluster_mc1_q3.create_mesh()
        cluster_mc1_q4 = Clustering(mc1_q4_mesh)
        cluster_mc1_q4.subdivide(2)
        cluster_mc1_q4.cluster(10000)
        mc1_q4_mesh = cluster_mc1_q4.create_mesh()

        cluster_trp_q1 = Clustering(trp_q1_mesh)
        cluster_trp_q1.subdivide(2)
        cluster_trp_q1.cluster(10000)
        trp_q1_mesh = cluster_trp_q1.create_mesh()
        cluster_trp_q2 = Clustering(trp_q2_mesh)
        cluster_trp_q2.subdivide(2)
        cluster_trp_q2.cluster(10000)
        trp_q2_mesh = cluster_trp_q2.create_mesh()
        cluster_trp_q3 = Clustering(trp_q3_mesh)
        cluster_trp_q3.subdivide(2)
        cluster_trp_q3.cluster(10000)
        trp_q3_mesh = cluster_trp_q3.create_mesh()
        cluster_trp_q4 = Clustering(trp_q4_mesh)
        cluster_trp_q4.subdivide(2)
        cluster_trp_q4.cluster(10000)
        trp_q4_mesh = cluster_trp_q4.create_mesh()


        # Mesh smoothing
        smooth_mc1 = remesh_mc1.smooth(n_iter=500)
        smooth_trp = remesh_trp.smooth(n_iter=500)
        mc1_q1_mesh = mc1_q1_mesh.smooth(n_iter=500)
        mc1_q2_mesh = mc1_q2_mesh.smooth(n_iter=500)
        mc1_q3_mesh = mc1_q3_mesh.smooth(n_iter=500)
        mc1_q4_mesh = mc1_q4_mesh.smooth(n_iter=500)
        trp_q1_mesh = trp_q1_mesh.smooth(n_iter=500)
        trp_q2_mesh = trp_q2_mesh.smooth(n_iter=500)
        trp_q3_mesh = trp_q3_mesh.smooth(n_iter=500)
        trp_q4_mesh = trp_q4_mesh.smooth(n_iter=500)

        mc1_q = [mc1_q1_mesh, mc1_q2_mesh, mc1_q3_mesh, mc1_q4_mesh]
        trp_q = [trp_q1_mesh, trp_q2_mesh, trp_q3_mesh, trp_q4_mesh]

        # Compute proximity using KD-TREE
        (area_mc1, com_mc1, mc1_q_area) = compute_proximity(smooth_trp, smooth_mc1, mc1_basename, str(int(frame_2)), mc1_q)
        (area_trp, com_trp, trp_q_area) = compute_proximity(smooth_mc1, smooth_trp, trp_basename, str(int(frame_2)), trp_q)

        print("Contact Area MC1 = {} mm^2".format(area_mc1), flush=True)
        print("Contact Area MC1 Quads = {} mm^2".format(mc1_q_area), flush=True)
        print("Contact Area TRP = {} mm^2".format(area_trp), flush=True)
        print("Contact Area TRP Quads = {} mm^2".format(trp_q_area), flush=True)

        frame_arr = np.array([str(int(frame_2)), 
                            str(area_mc1), 
                            str(mc1_q_area[0]), str(mc1_q_area[1]), str(mc1_q_area[2]), str(mc1_q_area[3]),
                            str(area_trp), 
                            str(trp_q_area[0]), str(trp_q_area[1]), str(trp_q_area[2]), str(trp_q_area[3]),
                            str(com_mc1[0]), str(com_mc1[1]), str(com_mc1[2]),
                            str(com_trp[0]), str(com_trp[1]), str(com_trp[2])])
        
        output_arr = np.vstack((output_arr, frame_arr))
        print()
        
    output_csv = os.path.join(output_path, study_id + "_" + movement + "_contact_area.csv")
    np.savetxt(output_csv, output_arr, delimiter=",", fmt="%s")


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("wbct_mask_dir", type=str, help="WBCT directory")
    parser.add_argument("dynact_reg_mask_dir", type=str, help="DYNACT directory")
    parser.add_argument("output_path", type=str, help="Output for CSV")

    args = parser.parse_args()
    wbct_mask_dir = args.wbct_mask_dir
    dynact_reg_mask_dir = args.dynact_reg_mask_dir
    output_path = args.output_path

    main(wbct_mask_dir, dynact_reg_mask_dir, output_path)