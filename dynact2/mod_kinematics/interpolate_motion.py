"""interpolate_motion.py

  Given a set of curve data, produces an interpolated curve with the input number of interpolation points, interpolated with a spline of degree <degree>

  curve data is expected to be in column 1 of the data path, if not, specify 'data_type' as the column header

  Usage: python interpolate_motion.py <subject> <path_to_data> [--degree, default=1] [--points, default=# points in csv] [--data_type, default=col 1]

Last Modified: Oct 27, 2025, Erica Baldesarra
Edits:
  - Oct 27, 2025: file creation, Erica Baldesarra

"""

import numpy as np
import pandas as pd
import argparse
from curve_data_utils import interpolate_curve
import matplotlib.pyplot as plt

if __name__ == '__main__':
  np.set_printoptions(legacy='1.25')
  parser = argparse.ArgumentParser()
  parser.add_argument("subject", type=int, help="Subject ID")
  parser.add_argument("motion_data_path", help = "Path to motion data excel/csv file.")
  parser.add_argument("--points", type = int, help = "Number of points to 'resample' data to.", default = None)
  parser.add_argument("--data_type", help = "Number of points to 'resample' data to.", default = None)
  parser.add_argument("--degree", type=int, default=1)

  args = parser.parse_args()

  # parse motion cycles from the frame_id file
  subject_data = pd.read_csv(args.motion_data_path)

  subject_data = subject_data[f"{args.data_type}"].to_numpy() if args.data_type is not None else subject_data[subject_data.columns[1]].to_numpy()
  
  print(f"DEBUG: subject_data: {subject_data}")

  # interpolate cycles linearly and resample to unanimous x-range
  
  if args.degree and args.points:
    interpolated_data = interpolate_curve(subject_data, args.degree, args.points)
  elif args.degree:
    interpolated_data = interpolate_curve(subject_data, args.degree, len(subject_data))
  elif args.points: 
    interpolated_data = interpolate_curve(subject_data, 1, args.points)
  else:
    interpolated_data = interpolate_curve(subject_data, 1, len(subject_data))

  
  # plot all curves along with average on same plot
  # todo: add better visualization method
  plt.plot(subject_data)
  plt.plot(np.linspace(0, len(subject_data), num=len(interpolated_data)),interpolated_data, '--')
  plt.show()
  
  print(f"Interpolated Curve: ")
  print(interpolated_data)
  exit(0)

