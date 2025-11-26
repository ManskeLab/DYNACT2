""" compute_motion.py

    Uses the computed scs csv files from compute_jcs.py to compute motion angles through dynamic frames

    Usage: python compute_motion.py <subject_id>

    Writes to outputs/motions/<subject_id>_<motion>_angles.csv

    Note: relies on file structure defined in compute_jcs.py.
    - future enhancements would allow any file structure and naming convention

    Edit History: 
      Nov 26, 2025: Docstring edits, Erica Baldesarra
      Oct 2025: File creation, Erica Baldesarra
"""
import argparse
import numpy as np
import os
from tmc_jcs_utils import read_scs_csv, compute_jcs


def compute_joint_translation(mc1_saddle: list | np.ndarray, trp_saddle: list | np.ndarray) -> np.ndarray:
  """Computes the translation of the TRP and MC1 relative to each other based on 

    'Translation of the metacarpal with respect to the trapezium is defined as
      the translation of the MC1 SCS origin with respect to the TPM SCS.'
    
    Args:
      mc1_saddle (array-like): 3D point of saddle of the MC1
      trp_saddle (array-like): 3D point of saddle of the TRP
    
    Returns:
      translation between MC1 and TRP (in 3D [x, y, z])
  """
  if isinstance(mc1_saddle, list):
    mc1_saddle = np.array(mc1_saddle)
  if isinstance(trp_saddle, list):
    trp_saddle = np.array(trp_saddle)
  return mc1_saddle - trp_saddle


def compute_angles(mc1_scs, trp_scs):
  """
    Function to compute joint rotations
    From compute_motion.py in ManskeLab/DYNACT2, chris branch:
    https://github.com/ManskeLab/DYNACT2/blob/chris/dynact2/compute_motion.py

    alpha (a) = abduction-adduction angle (X_MC1)
    beta  (b) = axial rotation (Floating axis)
    gama  (g) = flexion-extension (Z_TRP)

    Relative rotation matrix is assumed to have the following form:
    Rxyz = Rz * Ry * Rx
    Rxyz = 
        [ cos(b)cos(g)   (sin(a)sin(b)cos(g) + cos(a)sin(g))   (-cos(a)sin(b)cos(g) + sin(a)sin(g)) ]
        [ -cos(b)sin(g)  (-sin(a)sin(b)sin(g) + cos(a)cos(g))   (cos(a)sin(b)sin(g) + sin(a)cos(g)) ]
        [ sin(b)                    -sin(a)cos(b)                         cos(a)cos(b)              ]

    Args:
      mc1_scs: MC1 SCS in format: [[saddle], [x_axis], [y-axis], [z-axis]]
      trp_scs: TRP SCS in format: [[saddle], [x_axis], [y-axis], [z-axis]]

    Returns:
      angles: list in Degrees
  """
  # Matricies for axes should be formatted as follows:
  # Rxyz = [Rz  Ry  Rx]
  # Rxyz = [Zx  Yx  Xx]
  #        [Zy  Yy  Xy]
  #        [Zz  Yz  Xz]
  M_scs_MC1 = np.array([mc1_scs[1].T, mc1_scs[2].T, mc1_scs[3].T])
  M_scs_TRP = np.array([trp_scs[1].T, trp_scs[2].T, trp_scs[3].T])

  # Calculate angle of MC1 relative to TRP
  R_relative = np.linalg.inv(M_scs_TRP) * M_scs_MC1

  beta = np.arcsin(R_relative[2, 0])
  alpha = np.arcsin(-1 * R_relative[2, 1] / np.cos(beta))
  gama = np.arcsin(-1 * R_relative[1, 0] / np.cos(beta))

  angles = [np.rad2deg(alpha), np.rad2deg(beta), np.rad2deg(gama)]
  return angles


def compute_frame_angles(subject, motion):
  """ Compute the joint angles for each frame in the specified motion

  Args:
      subject (int | str): subject ID number
      motion (str): motion type: one of ['abad', 'key', 'opp']

  Returns:
      list: a list with each element containing the frame motion array for the frame at that index (+1)
  """
  overall_motion_results = []

  for frame in range(1, 61):
    # compute motion array with values ["FlexExt", "AbAd", "Rot", "X", "Y", "Z"]
    frame_motion_results = []

    if frame == 1:
      mc1_scs_csv = f"outputs/transformed_{motion.lower()}/mc1_cs_tfm_{subject}.csv"
      trp_scs_csv = f"outputs/transformed_{motion.lower()}/trp_cs_tfm_{subject}.csv"
    else:
      mc1_scs_csv = f"outputs/transformed_{motion.lower()}/volumes/mc1_cs_tfm_{subject}_{frame}.csv"
      trp_scs_csv = f"outputs/transformed_{motion.lower()}/volumes/trp_cs_tfm_{subject}_{frame}.csv"
    
    mc1_scs = read_scs_csv(mc1_scs_csv)
    trp_scs = read_scs_csv(trp_scs_csv)

    euler_zyx = compute_jcs(mc1_scs, trp_scs)

    angles = compute_angles(mc1_scs, trp_scs)
    frame_motion_results.append(angles)

    joint_xyz_translation = compute_joint_translation(mc1_scs[0], trp_scs[0])
    frame_motion_results.append(joint_xyz_translation)
    import itertools 
    # flatten list
    frame_motion_results = list(itertools.chain.from_iterable(frame_motion_results))

    overall_motion_results.append(frame_motion_results)

  return overall_motion_results


if __name__ == "__main__":
  parser = argparse.ArgumentParser(
      description="Compute and export joint angles for for MC1 and TRP based on Halilaj, et al. 2013."
  )

  parser.add_argument("subject_id", help="Subject to compute")
  args = parser.parse_args()


  for motion in ['abad', 'key', 'opp']:
    # setup motion-wide data
    # Create an array for the roatation/translantion results
    header_arr = np.array([["Frame", "AbAd", "Rot", "FlexExt", "X", "Y", "Z"]], dtype=object)
    frame_arr = np.arange(60).astype(str)
    frame_arr.shape = (60, 1)

    print(
        "Computing angles for "
        + str(args.subject_id) 
        + "\nMotion: "
        + motion.upper()
        + "..."
    )

    output_arr = frame_arr
    motion_results = compute_frame_angles(args.subject_id, motion)
    output_arr = np.hstack([output_arr, motion_results])
    output_arr = np.vstack([header_arr, output_arr])
    output_arr = output_arr.astype(str)

    print("Writing out values to CSV...")
    print()

    output_path = "outputs/motions/"
    output_csv = os.path.join(output_path, f"{str(args.subject_id)}_{motion.lower()}_angles_deg.csv")
    np.savetxt(output_csv, output_arr, delimiter=",", fmt="%s")

  exit(0)