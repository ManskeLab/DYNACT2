""" 
  compute_jcs.py

  Usage: python compute_jcs.py <scs_dir> <subject_id> <wbct_to_xct_mc1_tfm> <wbct_to_xct_trp_tfm>

  Writes to output files: outputs/transformed_<motion>/volumes/<bone>_cs_tfm_<subject_id>_<volume>.csv
  where <motion> is one of ['abad', 'key', 'opp'], bone is one of ['mc1', "trp"]

  Intermediate coordinate systems csvs are also written to outputs

  Last Modified: Oct 2025, Erica Baldesarra

  Note: the code relies on the folder structure of the DYNACT2/models directory in the 
        Manske Lab network drive. If this changes, appropriate code changes will need to follow for this
        code to work.
  This code is designed to work on either Windows or MacOS systems.
"""

#example usage (MacOS):
""" python compute_jcs.py "outputs/cs_result_csvs" 200 "/DYNACT2/models/DYNACT2_200/DYNACT2_200_MC1_WBCT_TO_XCT_REG.tfm" "DYNACT2/models/DYNACT2_200/DYNACT2_200_TRP_WBCT_TO_XCT_REG.tfm"
"""

import argparse
import os
import platform
import SimpleITK as sitk
import numpy as np
import pandas as pd
import pyvista as pv
from tmc_jcs_utils import save_coordinate_system_to_csv
from visualize_bone import plot_bone
from constants import bone_ids

def transform_scs(transform_path, scs, output_csv_path, inverse = False):
  """
  Transforms a set of coordinate system points using a given transform.
  
  transform_path: path to transform file
  scs: [[saddle] [x_axis] [y_axis] [z_axis]]
  output_csv_path: path to scs output csv file
  inverse: if True, applies the inverse of the transform. default = False

  Returns: transformed scs
  """
  # work with copies of data to keep original scs unchanged, or in case of pre-processing needs
  tfm_scs = np.copy(scs)

  # todo: error-check tfm file path
  transform = sitk.ReadTransform(transform_path)
  if inverse:
    transform.SetInverse()

  # transform saddle point
  tfm_scs_int = np.copy(tfm_scs)
  tfm_scs_int[0] = np.array(transform.TransformPoint(tfm_scs[0]))

  #transform axes as vectors
  tfm_scs_int[1] = transform.TransformVector(tfm_scs[1], tfm_scs_int[0])
  tfm_scs_int[2] = transform.TransformVector(tfm_scs[2], tfm_scs_int[0])
  tfm_scs_int[3] = transform.TransformVector(tfm_scs[3], tfm_scs_int[0])

  # create copy for output (todo: remove extra copy, used previously for postprocessing)
  tfm_scs_final = np.copy(tfm_scs_int)

  save_coordinate_system_to_csv(output_csv_path, tfm_scs_final[0], tfm_scs_final[1], tfm_scs_final[2], tfm_scs_final[3])

  return tfm_scs_final

def transform_to_motion(image_data_path, motion: str, mc1_scs, bone) -> None:
  """ Transforms the coordinate systems to the first frame of the specified motion

    image_data_path: path to image data (manskelab on ResearchFS)
    motion: str, one of ['abad', 'key', 'opp']
    scs: [[saddle] [x_axis] [y_axis] [z_axis]]
    bone: current bone for coordinate system

    prints to outputs folder in current directory
  """
  
  wbct_to_motion_tfm = os.path.join(image_data_path, f"DYNACT2_{args.subject_id}/DYNACT2_{args.subject_id}_WBCT/DYNACT2_{args.subject_id}_{bone.upper()}_WBCT_TO_{motion.upper()}_REG.tfm")
  
  bone_to_motion_cs_path = f"outputs/transformed_{motion.lower()}/{bone.lower()}_cs_tfm_{args.subject_id}.csv"
  scs_motion_start = transform_scs(wbct_to_motion_tfm, mc1_scs, bone_to_motion_cs_path, True)


  for frame in range(2, 61):
    motion_to_volume_tfm = os.path.join(image_data_path, f"DYNACT2_{args.subject_id}/DYNACT2_{args.subject_id}_{motion.upper()}/REGISTRATION/FinalTFMs/VOLUME_1_TO_{frame}_{bone.upper()}_REG.tfm")

    bone_to_volume_cs_path = f"outputs/transformed_{motion.lower()}/volumes/{bone.lower()}_cs_tfm_{args.subject_id}_{frame}.csv"
    scs_volume = transform_scs(motion_to_volume_tfm, scs_motion_start, bone_to_volume_cs_path, True)

  return


if __name__ == "__main__":
  parser = argparse.ArgumentParser(
      description="Compute and export joint coordinate systems for MC1 and TRP based on Halilaj, et al. 2013."
  )
  # note: bone coordinate system scs_dir is the output from tmc_jcs.py on xct images
  parser.add_argument("scs_dir", help="Path to scs directory")
  parser.add_argument("subject_id", help="Subject ID")
  # todo: can change from argument to inline, as long as consistent folder structure
  parser.add_argument("wbct_to_xct_mc1", help="Path to wbct to xct mc1 transform")
  parser.add_argument("wbct_to_xct_trp", help="Path to wbct to xct trp transform")
  parser.add_argument("models_dir", help="Path to models directory holding images")
  parser.add_argument("--debug", default=False)
  
  args = parser.parse_args()

  # debug statements for image information. 
  if args.debug:
    print(f"DEBUG: MC1 image direction:{sitk.ReadImage(args.mc1_bone).GetDirection()}")
    print(f"DEBUG: MC1 image spacing:{sitk.ReadImage(args.mc1_bone).GetSpacing()}")
    print(f"DEBUG: MC1 image origin:{sitk.ReadImage(args.mc1_bone).GetOrigin()}")

  # transform to dynact frame 1 
  manskelab_dir = args.models_dir

  #todo: make more adaptable to other file names (ie take filename template as input)

  for bone in bone_ids:
    # 1 transform to wbct
    scs_path = os.path.join(args.scs_dir, f"{bone.lower()}_coordinate_system_{args.subject_id}.csv")
  
    with open(scs_path, 'r') as f:
      xct_scs = pd.read_csv(f, usecols = [1, 2, 3]).values

    # do not use inverse here, tfm from fixed to moving (xct to wbct)
    cs_wbct = transform_scs(args.wbct_to_xct_mc1, xct_scs, False)
    cs_to_wbct_cs_path = f"outputs/transformed_wbct/{bone.lower()}_cs_tfm_{args.subject_id}.csv"

    save_coordinate_system_to_csv(cs_to_wbct_cs_path, cs_wbct[0], cs_wbct[1], cs_wbct[2], cs_wbct[3])

    # transform through motion frames
    for motion in ['abad', 'key', 'opp']:
      transform_to_motion(manskelab_dir, motion, cs_wbct, bone)

  exit(0)

