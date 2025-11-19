"""
identify_neutral_frame.py 

Using JSW files, identify the face with the minimum distance for each frame. 
Then calculates the maximum of these minimum distances and prints the frame number. 

Usage: identify_neutral_frame.py <path_to_jsw_dir> <angle_file> [--output_file]

Edit History:
  - Nov 4, 2025: File creation, Erica Baldesarra

Note, jsw files are stored with the naming convention VOLUME_{i}_{MC1/TRP}_PATCH_JSW.xlsx
      data is stored in columns x, y, z, jsw, where [x,y,z] is the location of the jsw's associated face

"""

import argparse
import sys
from curve_data_utils import read_data_file, get_motion_cycles
import numpy as np
import os
import pandas as pd
from scipy.stats import percentileofscore
from constants import angle_dirs

def summarize_frame(calculation: str, jsw_data: np.ndarray | list, trim: bool = True):
  """Summarize the data from a single frame by calculating a single value

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
    jsw_data_trimmed = jsw_data[(jsw_data >= np.percentile(jsw_data, 5)) & (jsw_data <= np.percentile(jsw_data, 95))]
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


if __name__ == "__main__":
  parser = argparse.ArgumentParser()
  parser.add_argument("jsw_dir", help="Path to directory with jsw information for subject, motion")
  parser.add_argument("angle_file", help="Path to file with joint angle info")
  parser.add_argument("--output_file", default=None, help="path to excel file to store JSW mins")
  parser.add_argument("--frames", type = int, default=60)
  parser.add_argument("--max_of", default='min', type=str, help="string representing which calculation to pull for JSW per frame. Default=min. Options=min, mean/avg, max")
  parser.add_argument("--subject", type=int, help="Subject to identify")
  parser.add_argument("--motion_frames", help="file path to identified motion frames of subject")

  args = parser.parse_args()

  # identify the jsw value (face) per frame
  jsw_frames = []
  for frame in range(args.frames):
    frame_jsw_file = os.path.join(args.jsw_dir, f"VOLUME_{frame + 1}_MC1_PATCH_JSW.xlsx")
    # todo: create proper file name to index per_frame
    jsw_face_data = read_data_file(frame_jsw_file, columns = ['jsw']).to_numpy()
    #print(f"DEBUG: jsw_face_data {jsw_face_data}")
    jsw_frames.append(summarize_frame(args.max_of, jsw_face_data))

  #print(f"DEBUG: jsw_frames {jsw_frames}")
  
  # todo: print jsw data
  if args.output_file:
    data_frame = pd.DataFrame({"Frame": range(args.frames),
                              f"{args.max_of}_jsw": jsw_frames })
    data_frame.to_excel(args.output_file, index=False) 

  max_frame = np.argmax(jsw_frames)
  print(f"Max frame: {max_frame + 1} (max frame index = {max_frame})")
  print(f"Max jsw (of all {args.max_of}s): {jsw_frames[max_frame]}")

  angle_data = read_data_file(args.angle_file, columns = angle_dirs, rows = [max_frame])

  print(f"Angles at max jsw: \n{angle_data}")

  if args.subject and args.motion_frames:
    _, motion_cycles = get_motion_cycles(pd.read_excel(args.motion_frames), args.subject)
    for cycle in motion_cycles:
      if (max_frame + 1) in np.arange(cycle[0], cycle[2] + 1):
        print(f"Percent of motion curve: {percentileofscore(np.arange(cycle[0], cycle[2] + 1), max_frame + 1)}%")
        exit(0)
    
    print("Max JSW frame not in identifiable/acceptable motion")
