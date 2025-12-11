# ----------------------------------------------------------------
# mesh_utils.py 
#
# Created by: Chris Brunet
# Created on: June 19, 2025
#
# Utils used for generating and performing computations on meshes
#
# ----------------------------------------------------------------

import vtk
import pyvista as pv
import numpy as np
from pyacvd import Clustering
from scipy.spatial.transform import Rotation as R

def generate_mesh(file, vertices = 20000):
    """
    Adapted from Tadiwa 2024

    Creates a surface mesh file compatible with PyVista from a .nii mask file

    Args:
        file (str): Path to the grayscale .nii bone mask.
        
    Returns:
        surf_mesh1 (pyvista.PolyData): A surface mesh
    """
    org_contour = pv.read(file) 
    # -------------------------------------------------------------------------- #
    #  Step 1:  Generate bone surface models from segmentation image
    # -------------------------------------------------------------------------- #
    #   Contour a single label, generate surface model and smooth surface
    contour1 = org_contour.image_threshold(threshold = [1,1])
    surf_mesh1 = contour1.contour([1])
    surf_mesh1 = surf_mesh1.smooth_taubin(n_iter = 200, pass_band = 0.015)
    surf_mesh1['distance'] = np.empty(surf_mesh1.n_points)  # array for scalar measures, distance is for joint space width
    surf_mesh1['thickness'] = np.empty(surf_mesh1.n_points) # array for scalar measures, thickness is for subchondral bone plate thickness
    surf_mesh1['distance'][:] = np.nan
    surf_mesh1['thickness'][:] = np.nan
    surf_mesh1.triangulate()

    # -------------------------------------------------------------------------- #
    #  Step 2:  Relax models to ensure equal-sized triangular mesh elements
    # -------------------------------------------------------------------------- #
    #   Bone 1 mesh
    surf_clust1 = Clustering(surf_mesh1)
    surf_clust1.subdivide(3)
    surf_clust1.cluster(vertices) # mesh with $vertices vertices
    surf_mesh1 = surf_clust1.create_mesh()
    surf_mesh1['distance'] = np.empty(surf_mesh1.n_points)  # array for scalar measures, distance is for joint space width
    surf_mesh1['thickness'] = np.empty(surf_mesh1.n_points) # array for scalar measures, thickness is for subchondral bone plate thickness
    surf_mesh1['distance'][:] = np.nan
    surf_mesh1['thickness'][:] = np.nan

    return surf_mesh1

def jsm_raytrace(source_mesh_pv, target_mesh_pv, ray_length):
    """
    Adapted from Tadiwa 2023

    Calculates Joint Space Width (JSW) by casting rays from the centroids of each face
    of the source mesh towards the target mesh, along the face normals.

    Args:
        input_image_path (str): Path to the grayscale NIFTI image.
        source_mesh_pv (pyvista.PolyData): The source surface mesh (e.g., femur).
        target_mesh_pv (pyvista.PolyData): The target surface mesh (e.g., tibia).
        ray_length (float): The maximum length of the ray to cast for intersection.

    Returns:
        tuple: A tuple containing:
            - jsm (pyvista.PolyData): The source mesh with JSW scalar data
                                      attached to its faces (cells).
            - jsw (numpy.ndarray): An array of the calculated JSW values for each face.
    """
    # Ensure connectivity for largest component
    source_mesh = source_mesh_pv.connectivity(extraction_mode='largest')
    target_mesh = target_mesh_pv.connectivity(extraction_mode='largest')

    # Compute cell normals for the source mesh.
    # These will be used as the ray directions.
    source_mesh.compute_normals(cell_normals=True, point_normals=False, inplace=True)
    source_mesh_cell_normals_data = source_mesh.cell_normals

    # Calculate centroids of each face (cell) on the source mesh
    face_centroids = source_mesh.cell_centers().points

    # Initialize a scalar array for JSW estimates on faces (cells)
    # The 'distance' array will now be associated with cells, not points.
    source_mesh['distance'] = np.empty(source_mesh.n_cells)
    source_mesh['distance'][:] = np.nan

    ''' Sets the object to look for during mapping:
       Normal rays are cast from the source surface (e.g., femur) towards the target surface (e.g., tibia) '''
    obbObject_target = vtk.vtkOBBTree()
    obbObject_target.SetDataSet(target_mesh) # target_mesh is a PyVista object, which is also a vtkPolyData
    obbObject_target.BuildLocator()

    intersect_count = 0
    success_count = 0
    intersecting_rays = []
    source_mesh['distance'][0] = 0

    ''' Loop through all faces (cells) of the source mesh to cast rays '''
    for cell_idx in range(source_mesh.n_cells):
        start_point = face_centroids[cell_idx]
        face_normal = source_mesh_cell_normals_data[cell_idx]

        # Define a ray that extends in both positive and negative normal directions
        # This ensures that even if the target mesh is "behind" the source mesh,
        # we can still find an intersection.
        # The length should be sufficient to cover expected overlaps and gaps.
        extended_ray_p1 = start_point - ray_length * face_normal
        extended_ray_p2 = start_point + ray_length * face_normal

        intersect_points_vtk = vtk.vtkPoints()
        intersect_cell_ids_vtk = vtk.vtkIdList()

        # IntersectWithLine returns 1 if an intersection is found, 0 otherwise
        if obbObject_target.IntersectWithLine(extended_ray_p1, extended_ray_p2, intersect_points_vtk, intersect_cell_ids_vtk):
            intersect_count += 1

            # Find the intersection point closest to 'start_point'
            closest_ip = None
            min_dist_sq = float('inf')

            for i in range(intersect_points_vtk.GetNumberOfPoints()):
                current_ip = np.array(intersect_points_vtk.GetPoint(i))
                dist_sq = np.sum((current_ip - start_point)**2)
                if dist_sq < min_dist_sq:
                    min_dist_sq = dist_sq
                    closest_ip = current_ip

            if closest_ip is not None:
                # Calculate the signed distance
                vector_to_intersection = closest_ip - start_point
                jsw_val = np.dot(vector_to_intersection, face_normal)

                if not np.isnan(jsw_val): # Check if jsw_val is a valid number
                    success_count += 1
                    # Assign the JSW value to the corresponding cell (face)
                    source_mesh['distance'][cell_idx] = jsw_val
                    intersecting_rays.append((start_point, closest_ip))


    # The thresholding will now apply to cells based on their 'distance' scalar.
    # The output mesh will contain faces that meet the distance criteria.
    jsm = source_mesh.threshold(value=(-ray_length, ray_length), scalars='distance', preference='cell').extract_surface()

    # Retrieve the JSW values from the 'distance' array associated with the cells of the new mesh
    # This will now contain one value per cell (face) in the `jsm` mesh.
    jsw = jsm['distance']
    print(f"\t\t\tResulting JSM mesh has {jsm.n_cells} faces with {len(jsw)} JSW data points.")

    return jsm, jsw, intersecting_rays

def check_intercept(mesh_1, mesh_2):
  """
  ***IMPORTANT FUNCTION***
  - this is a temporary fix to make up for failures of sequential registration results. properly registered masks should not need this

  Checks for intersection 2 meshes and translates one mesh along x-axis until they no longer touch

  Args:
    mesh_1 (pyvista.PolyData): mesh that does NOT get translated (usually MC1)
    mesh_1 (pyvista.PolyData): mesh that get translated (usually TRP)
  """
  required_translation_x = 0
  intersection, _, _  = mesh_1.intersection(mesh_2, split_first=True, split_second=True)

  if intersection.n_points == 0:
     print("\t\tNo Intersection found in meshes.")

  while intersection.n_points > 0:
    intersection_bounds = intersection.bounds
    overlap_distance_x = intersection_bounds[1] - intersection_bounds[0]

    if intersection_bounds[0] > 0 and intersection_bounds[1] > 0:
      required_translation_x = overlap_distance_x + 0.01
    else: 
      required_translation_x = -1 * overlap_distance_x - 0.01

    mesh_2.translate([required_translation_x, 0, 0], inplace=True)

    intersection, _, _ = mesh_1.intersection(mesh_2, split_first=True, split_second=True)

    if intersection.n_points == 0:
      print(f"\t\tMeshes successfully transformed and no longer intersect. Translation is: {required_translation_x}")
    else:
      print("\t\tMeshes still intersect after transformation. Trying Again...")

def compute_normal_vector(mc1_bone_mesh, mc1_articular_mesh):
  """
  Computes normal vector from the MC1 articular surface

  Args:
    mc1_bone_mesh (pyvista.PolyData): Mesh for MC1 bone
    mc1_articular_mesh (pyvista.PolyData): Mesh for MC1 articular surface

  Returns:
    normal_vector (list): [x,y,z] components of normal vector
  """

  # take avg direction of articular surface normals
  mc1_articular_mesh.compute_normals(cell_normals=False, point_normals=True, auto_orient_normals=True, inplace=True)
  articular_normals = mc1_articular_mesh.point_data['Normals']
  centroid_articular = np.array(mc1_articular_mesh.center)
  normal_vector = np.mean(articular_normals, axis=0)
  normal_vector = normal_vector / np.linalg.norm(normal_vector) 

  # checks if direction is pointing towards or away from the centre of the bone
  center_of_bone = np.array(mc1_bone_mesh.center)
  if np.dot(normal_vector, (centroid_articular - center_of_bone)) < 0:
      normal_vector = -normal_vector

  return normal_vector

def compute_alignment_matrix(source, target):
    try:
        _, tfm = source.align(
                    target,
                    max_landmarks=500,  
                    max_iterations=800,
                    max_mean_distance=1e-6,
                    start_by_matching_centroids=True,
                    return_matrix=True,
                )
    except:
        tfm = np.eye(4)

    return tfm