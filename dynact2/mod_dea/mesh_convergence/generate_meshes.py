"""
  Generates 3D bone meshes and joint surface patch meshes for MC1 and TRP bone masks

  Edit History:
    - 2025-12-08: File creation - Erica Baldesarra

  Example Usage: python generate_meshes.py <--mc1_mask> <--trp_mask> --mesh_fp_temp="${subject}_VOLUME_${ref_frame}_{bone}_MESH.stl" --patch_fp_temp="${subject}_VOLUME_${ref_frame}_{bone}_SURF_PATCH.stl" --output_dir="outputs//${subject}/${motion}" --verts=200000

"""
import argparse
from mesh_utils import generate_mesh, jsm_raytrace, compute_normal_vector
from tmc_dea_preprocess import save_jsw
from constants import bone_ids
import os
import numpy as np
import SimpleITK as sitk

def resample_image(orig, sample_to, write_path = None):
  """Resamples an image to a reference image

  Args:
      orig (str | path): Image to resample
      sample_to (str | path): Resample reference image
      write_path (str | path, optional): write path for image. None writes to original image location.
  """
  orig_img = sitk.ReadImage(orig)
  samp_ref_img = sitk.ReadImage(sample_to)
  print("\tResampling Images")

  img_resampled = sitk.Resample(image1=orig_img, referenceImage=samp_ref_img)

  if write_path is None:
    write_path = orig
  sitk.WriteImage(img_resampled, write_path)

if __name__ == "__main__":
  parser = argparse.ArgumentParser()
  parser.add_argument("--mc1_mask_fp", nargs='?', default=None)
  parser.add_argument("--trp_mask_fp", nargs='?', default=None)
  parser.add_argument("--mc1_resamp", default=None)
  parser.add_argument("--trp_resamp", default=None)
  parser.add_argument("--verts", default=200000, type=int)
  parser.add_argument("--output_dir", default="outputs")
  parser.add_argument("--mesh_fp_temp", default="{bone}_MESH.stl")
  parser.add_argument("--patch_fp_temp", default="{bone}_PATCH.stl")
  parser.add_argument("--jsw_fp_temp", default="{bone}_PATCH_JSW.csv")

  # if first frame, use WBCT to Motion transformed mask.
  # if any other frame, use VOLUME_1_to_FRAME_MASK in registered masks

  args = parser.parse_args()

  mc1_mesh = None
  trp_mesh = None
  if args.mc1_mask_fp:
    if args.mc1_resamp and args.mc1_resamp != "":
      resample_image(args.mc1_mask_fp, args.mc1_resamp)
    mc1_mesh = generate_mesh(args.mc1_mask_fp, args.verts)

  if args.trp_mask_fp:
    if args.trp_resamp and args.trp_resamp != "":
      resample_image(args.trp_mask_fp, args.trp_resamp)
    trp_mesh = generate_mesh(args.trp_mask_fp, args.verts)

  if trp_mesh and mc1_mesh:
    mc1_patch, mc1_jsw, _ = jsm_raytrace(mc1_mesh, trp_mesh, 5) # ray-length of 5 to limit patch extending past contact area
                                                                  # other values should be tested
    trp_patch, trp_jsw, _ = jsm_raytrace(trp_mesh, mc1_mesh, 5)

  # assign JSW values to meshes
  mc1_patch['distance'] = mc1_jsw
  trp_patch['distance'] = trp_jsw

  for bone in bone_ids:
    out_mesh_fp = os.path.join(args.output_dir, args.mesh_fp_temp.format(bone=bone))
    out_patch_fp = os.path.join(args.output_dir, args.patch_fp_temp.format(bone=bone))
    out_jsw_fp = os.path.join(args.output_dir, args.jsw_fp_temp.format(bone=bone))
    mc1_mesh.save(out_mesh_fp) if bone == 'MC1' else trp_mesh.save(out_mesh_fp)
    mc1_patch.save(out_patch_fp) if bone == "MC1" else trp_patch.save(out_patch_fp)
    save_jsw(mc1_patch, out_jsw_fp) if bone == 'MC1' else save_jsw(trp_patch, out_jsw_fp)

  normal_vector = compute_normal_vector(mc1_mesh, mc1_patch)
  normal_vector_and_jsw = np.append(normal_vector, [25, np.mean(mc1_jsw)])
  normal_vector_output = os.path.join(args.output_dir, "ref_normal_vector.csv")
  np.savetxt(normal_vector_output, normal_vector_and_jsw, fmt="%.8f", delimiter=",")





