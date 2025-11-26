"""
normalize_data.py

'Normalize' data based on some reference frame (calculated or provided)
  - Report data based on relative change to normal frame

Edit History:
  - Nov 24, 2025: Have file be re-usable on frame-specified data or face-specified data
  - Nov 18, 2025: File creation, Erica Baldesarra

"""

import argparse
import sys
from curve_data_utils import read_data_file, get_motion_cycles, write_to_excel, extract_data
import numpy as np
import os
import pandas as pd
from scipy.stats import percentileofscore
from constants import angle_dirs
from argparse_utils import create_parser_optionals
import matplotlib.pyplot as plt

def summarize_frame(calculation: str, jsw_data: np.ndarray | list, trim: bool = True):
  #todo: have calculation take function directly
  """Summarize the data from a single frame by calculating a single result

  Args:
      calculation (AnyOf['min', 'max', 'mean', 'avg']): type of calculation to perform
      jsw_data (np.ndarray | list): array of JSW data for faces of object in frame
      trim (bool): determine whether or not to trim data to within 5th and 95th percentile

  Raises:
      NameError: if calculation is not one of 'min', 'max', 'mean'

  Returns:
      int | float: Single value calculated for frame face data
  """
  # remove outliers:
  if trim:
    jsw_data_trimmed = jsw_data[(jsw_data >= np.percentile(jsw_data, 5)) 
                                & (jsw_data <= np.percentile(jsw_data, 95))]
  else:
    jsw_data_trimmed = jsw_data

  if calculation.lower() == 'min':
    return min(jsw_data_trimmed)
  elif calculation.lower() in ['mean', 'avg']:
    return np.mean(jsw_data_trimmed)
  elif calculation.lower() == 'max':
    return max(jsw_data_trimmed)
  else:
    raise NameError(f"{calculation} is not a valid calculation type")

def summarize_frames(frames: int, data_cols: str | list[str], data_dir: str | os.PathLike, data_path_template: str, summary: str):
  """Summarize frame face data over all frame data

  Args:
      frames (int): number of frames
      data_col (str): data to summarize over
      data_dir (str | os.Path): directory hosting frame data
      data_path_template (str): filename with frame data, templated with '{frame}'
      summary (str): calculation to summarize with

  Returns:
      list: array of summarized values per frame
  """

  data_frames = []
  for frame_idx in range(frames):
    frame_file = data_path_template.format(frame = frame_idx + 1)
    frame_data_fp = os.path.join(data_dir, frame_file)
    face_data = read_data_file(frame_data_fp, columns = [data_cols]).to_numpy()
    data_frames.append(summarize_frame(summary, face_data))

  return data_frames

def identify_max_frame(frame_data: list, extra_data_file: str | os.PathLike = None, extra_data_cols: list[str] | str = None):
  """Identify max frame given summarized frame data, and optionally associated data at that frame

  Args:
      frame_data (list): summarized frame data, single result per frame (must be accessible by np.argmax)
      extra_data_file (str | os.Path, optional): path to file containing additional frame data. Defaults to None.
      extra_data_cols (list[str] | str, optional): specified columns to identify data of max frame. Defaults to None.

  Returns:
      int, Any: index of frame where maximum occurs, extra data associated with that frame index
  """

  # todo: have function take function argument instead of only argmax
  max_frame_idx = np.argmax(frame_data)
  extra_data = extract_data(max_frame_idx, extra_data_file, extra_data_cols)
  
  return max_frame_idx, extra_data

def percent_of_motion(motion_cycles: list, max_frame_idx: int):
  """Calculate the percentage within a motion at which a frame is situated

  Args:
      motion_cycles (list[int, int, int]): tuples of identifiable motion cycles (in frames) in form [start, extreme, end]
      max_frame_idx (int): index of max frame (starting at 0)

  Returns:
      num, int: percent of motion, cycle in which it occured
  """
  percent = None
  cycle = None
  for cycle_index in motion_cycles:
    if (max_frame_idx + 1) in np.arange(cycle_index[0], cycle_index[2] + 1):
      percent = percentileofscore(np.arange(cycle_index[0], cycle_index[2] + 1), max_frame_idx + 1)
      cycle = cycle_index
  
  return percent, cycle

def normalize_data(frames: int, data_dir, data_fp_template, normal_frame_idx, face_summary = None, data_cols = None):
  """Normalize data using reference frame and calculating relative change in other frames

  Args:
      frames (int): number of frames in motion
      data_dir (str| pathlike): _description_
      data_fp_template (str): string template for filename of frame data, 'frame' as a templated variable
      normal_frame_idx (int): index of the frame to 'normalize' to
      face_summary (function): funciton to apply to frame data to summarize values accross faces. If none, data is assumed to be organized per frame

  Returns:
      list[int]: The finalized normalized values
  """
  normal_frame_value = 0
  data = None
  if face_summary:
    normal_frame_fp = os.path.join(data_dir, data_fp_template.format(frame = normal_frame_idx + 1))
    normal_frame_data = read_data_file(normal_frame_fp, data_cols).to_numpy()

    normal_frame_value = face_summary(normal_frame_data)
  else:
    data = read_data_file(os.path.join(data_dir, data_fp_template), data_cols).to_numpy()
    normal_frame_value = data[normal_frame_idx]

  original_frames = []
  normalized_frames = []
  for frame_idx in range(frames):
    frame_value = 0
    if face_summary:
      frame_fp = os.path.join(data_dir, data_fp_template.format(frame = frame_idx + 1))
      frame_data = read_data_file(frame_fp, data_cols).to_numpy()
      original_frames.append(face_summary(frame_data))
      frame_value = face_summary(frame_data) - normal_frame_value
    else:
      orig_frame_value = data[frame_idx]
      original_frames.append(orig_frame_value)
      frame_value = orig_frame_value - normal_frame_value

    normalized_frames.append(frame_value)
  
  return normalized_frames, original_frames

def trimmed_face_mean(face_data: pd.DataFrame, lower = 5, upper = 95):
  """Calculate mean of all face data trimmed between lower and upper percentiles

  Args:
      face_data (pandas.DataFrame): _description_
      lower (num, optional): Lower percentile to trim to. Defaults to 5.
      upper (num, optional): Upper percentile to trim to. Defaults to 95.

  Returns:
      np.float: Mean of trimmed face data
  """
  face_data_trimmed = face_data[(face_data >= np.percentile(face_data, lower)) & (face_data <= np.percentile(face_data, upper))]
  return np.mean(face_data_trimmed)

if __name__ == "__main__":
  np.set_printoptions(legacy='1.25')
  parser = create_parser_optionals()
  parser.add_argument("stress_dir", help="Path to directory with stress information for subject, motion (to be normalized)")
  parser.add_argument("--ref_input_dir", help="Path to directory with normal reference information for subject, motion")
  parser.add_argument("--angle_file", help="Path to file with joint angle info, to extract angle at normal frame")
  parser.add_argument("--normal_frame_idx", default=None, type=int, help="Normal frame index, if known. Skips calculations to find max JSW frame.")
  parser.add_argument("--ref_input_fp_template", default="VOLUME_{frame}_MC1_PATCH_JSW.xlsx", help="Template for filepath with normal reference data for frame. Must include '/{frame/}'")
  parser.add_argument("--stress_fp_template", default="VOLUME_{frame}_MC1_STRESS.xlsx", type=str, help="Template for filepath with stress data for frame. Must include '/{frame/}'")
  parser.add_argument("--summarized", action='store_true', default=False, help="Set to true if data to normalize is already summarized by 'per frame'. File should have a header for the data column with a cell per frame for data")
  parser.add_argument("--data_cols_to_normalize", default=None, help="Data columns to index for data to normalize. (use --data_cols for data used to find normal frame)")

  args = parser.parse_args()
  percent = None
  jsw_frames = None
  angle_data = None
  if not args.normal_frame_idx:
    jsw_frames = summarize_frames(args.frames, args.data_cols, args.ref_input_dir, args.ref_input_fp_template, args.max_of)
    max_frame_idx, angle_data = identify_max_frame(jsw_frames, args.angle_file)

    if args.verbose >= 1:
      print(f"Summarized Frames {args.max_of}:")
      print(f"{np.vstack([np.arange(1, args.frames + 1), jsw_frames])}")
      print(f"Max jsw (of all {args.max_of}s): {jsw_frames[max_frame_idx]}")
  else:
    max_frame_idx = args.normal_frame_idx
    if args.angle_file:
      angle_data = extract_data(max_frame_idx, args.angle_file)


  if args.verbose >= 1:
    print(f"Max frame: {max_frame_idx + 1} (max frame index = {max_frame_idx})")
    print(f"Angles at normal frame: \n{angle_data}")

  if args.subject and args.motion_frames:
    _, motion_cycles = get_motion_cycles(pd.read_excel(args.motion_frames), args.subject)
    percent, cycle = percent_of_motion(motion_cycles, max_frame_idx)
    if args.verbose >= 2 or args.debug:
      if percent:
        print(f"Max JSW frame occurs at {percent}% of motion between fram {cycle[0]} and frame {cycle[2]}")
      else:
        print("Max JSW frame not in identifiable/acceptable motion")


  if args.summarized:
    normalized_stress, mean_stress = normalize_data(args.frames, args.stress_dir, args.stress_fp_template, max_frame_idx, trimmed_face_mean)
  else:
    normalized_stress, mean_stress = normalize_data(args.frames, args.stress_dir, args.stress_fp_template, max_frame_idx, data_cols=args.data_cols_to_normalize)

  if args.verbose >= 1 or args.debug:
    print(f'Normalized values: \n {np.vstack(normalized_stress)}')
  
  plt.plot(np.arange(1, args.frames + 1), normalized_stress)
  plt.plot(max_frame_idx + 1, normalized_stress[max_frame_idx], 'or', label='Normal frame')
  plt.legend()
  plt.grid()
  if args.plot_savefile:
    plt.savefig(args.plot_savefile)
  if args.plot:
    plt.show()

  if args.output_file and not args.nw:
    args.subject = args.subject if args.subject else ""
    write_to_excel(args.output_file, 
                   [[args.subject,
                    max_frame_idx,
                    str(mean_stress),
                    str(normalized_stress), 
                    np.mean(normalized_stress), 
                    max(normalized_stress), 
                    min(normalized_stress), 
                    max(normalized_stress) - min(normalized_stress),
                    str(percent) if percent else "",
                    str(jsw_frames) if jsw_frames else "",
                    str(jsw_frames[max_frame_idx]) if jsw_frames else "",
                    angle_data['FlexExt'].to_numpy()[0] if isinstance(angle_data, pd.DataFrame) else '',
                    angle_data['AbAd'].to_numpy()[0] if isinstance(angle_data, pd.DataFrame)else '',
                    angle_data['Rot'].to_numpy()[0] if isinstance(angle_data, pd.DataFrame) else '',
                    angle_data['X'].to_numpy()[0] if isinstance(angle_data, pd.DataFrame)else '',
                    angle_data['Y'].to_numpy()[0] if isinstance(angle_data, pd.DataFrame)else '',
                    angle_data['Z'].to_numpy()[0] if isinstance(angle_data, pd.DataFrame) else ''
                    ]], 
                    ['Subject',
                     'Normal Frame Index',
                     'Mean Stress (per frame)',
                     'Normalized Mean Stress', 
                     'Mean Normalized Stress', 
                     'Max Normalized Stress',
                     'Min Normalized Stress',
                     'Stress Difference (max-min)',
                     'Percent of motion at max frame (if identifiable)',
                     f'JSW per frame ({args.max_of})', 
                     'JSW at max frame', 
                     'FlexExt at max frame', 
                     'AbAd at max frame', 
                     'Rot at max frame',
                     'x-travel at max frame', 
                     'y-travel at max frame', 
                     'z-travel at max frame'])

  exit(0)
  

  

