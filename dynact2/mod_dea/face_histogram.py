"""
A script to generate histograms of 3D mesh triangulated face data (e.g. stress, force)

Usage: python face_histogram.py <input_filepath OR input_dir, in_fp_template, frames/subject>  [--data_cols] [--data_rows] [--nbins | --bin_alg] [-p] [--plot_savefile] [--data_type] [-v]

Can be used on one frame or all frames in a subject (specify --frames: int), or over all subjects (specify --subjects: list(str))

options:
  -h, --help            show this help message and exit
  --input_filepath INPUT_FILEPATH
                        Path to input data
  --input_dir INPUT_DIR
                        path to data input directory. Assumes some file structure/naming convention or uses argument in_fp_template
  --in_fp_template IN_FP_TEMPLATE
                        Filepath templated with both {subject} and {frame}
  --data_type DATA_TYPE
                       type of data histogram is displaying
  --data_rows DATA_ROWS
                        Data rows to index. Defaults to all rows
  --data_cols DATA_COLS
                        Data columns to index. Defaults to all columns
  -p, --plot            Include flag to produce plots
  --plot_savefile PLOT_SAVEFILE
                        Filename to save plot to. No plot is saved if not provided.

  --frames FRAMES       Number of frames to analyze. Used in in_fp_template
  --subjects [SUBJECTS ...]
                        specify subject ID's to apply this to. Used in in_fp_template
  -d, --debug
  -v, --verbose
  --nbins NBINS
  --bin_alg BIN_ALG

"""

import textwrap
import matplotlib.pyplot as plt
import os
from argparse_utils import create_parser_optionals
from curve_data_utils import read_data_file, generate_plot
import numpy as np

def draw_histogram(ax: plt.Axes, x_data, nbins: int | str | None = None, x_axis: str = None) -> None:
  """Plots a histogram of the data distribution onto the given axis

  Args:
      ax (plt.Axes): Axis to plot data onto
      x_data (array_like): data to plot
      nbins (int | None, optional): Number of bins to distribute data into, 
                                    or algorithm used by numpy to determine bin number. Defaults to None.
      x_axis (str, optional): X-axis label. Defaults to None.
  """
  if nbins and x_axis:
    x_axis = textwrap.fill(x_axis, width=20)
    ax.hist(x_data, nbins, label=x_axis)
  elif nbins:
    ax.hist(x_data, nbins)
  elif x_axis:
    x_axis = textwrap.fill(x_axis, width=20)
    ax.hist(x_data, label=x_axis)
  else:
    ax.hist(x_data)

  ax.set_ylabel("Frequency (Total Faces)")
  return

if __name__ == "__main__":
  parser = create_parser_optionals()
  parser.add_argument("--nbins", default=None, type=int, help="Number of bins for histogram to display")
  parser.add_argument("--bin_alg", default=None, type=str, help="Algorithm for numpy to use to calculate number of bins for histogram to display")
  parser.add_argument("--ref_frames", nargs='*', default=[], help="list of reference frames to apply instead of total frames. Input should have the same length as --subjects. If not specified, all frames per subject are used.")

  args = parser.parse_args()

  face_data = np.array([])

  # determine if singe file, file per frame or file per subjects
  if args.input_filepath:
    print(f"Reading data from path {args.input_filepath}...") if args.verbose >=1 else None
    face_data = np.concatenate((face_data, read_data_file(args.input_filepath, args.data_cols, args.data_rows).to_numpy()))
  elif args.input_dir and args.in_fp_template and args.subjects and (args.frames or args.ref_frames):
    print(f"DEBUG: Reference frames used as input: {args.ref_frames}") if args.debug else None
    for idx, subject in enumerate(args.subjects):
      subject_frames = [args.ref_frames[idx]] if len(args.ref_frames) == len(args.subjects) else range(1, args.frames + 1)
      print(f"DEBUG: Reference frames used for subject {subject}: {subject_frames}") if args.debug else None
      for frame in subject_frames:
        input_fp=""
        if "frame" in args.in_fp_template and 'subject' in args.in_fp_template:
          input_fp = os.path.join(args.input_dir, args.in_fp_template.format(subject = subject, frame = frame))
        else:
          raise AttributeError(f"ERROR: template must include subject and frame variable")
        
        if not os.path.exists(input_fp):
          print(f"File path {input_fp} does not exist. Skipping...")
          continue
        print(f"Reading data from path {input_fp}...") if args.verbose >=1 else None
        face_data = np.concatenate((face_data, read_data_file(input_fp, args.data_cols, args.data_rows).to_numpy()))
  elif args.input_dir and args.in_fp_template and (args.frames or args.ref_frames):
    subject_frames = args.ref_frames if len(args.ref_frames) > 0 else range(1, args.frames + 1)
    for frame in subject_frames:
        input_fp=""
        if "frame" in args.in_fp_template:
          input_fp = os.path.join(args.input_dir, args.in_fp_template.format(frame = frame))
        else:
          raise AttributeError(f"ERROR: template must include frame variable")
        
        if not os.path.exists(input_fp):
          print(f"File path {input_fp} does not exist. Skipping...")
          continue
        print(f"Reading data from path {input_fp}...") if args.verbose >=1 else None
        face_data = np.concatenate((face_data, read_data_file(input_fp, args.data_cols, args.data_rows).to_numpy()))
  else:
    raise AttributeError("No input data file or directory was correctly provided.")

  face_data = face_data[face_data > 0]

  fig, ax = plt.subplots()

  if args.nbins:
    draw_histogram(ax, face_data, args.nbins, args.data_type)
  elif args.bin_alg:
    draw_histogram(ax, face_data, args.bin_alg, args.data_type)
  
  if args.nbins and args.bin_alg and (args.verbose >=1 or args.debug):
    print(f"WARNING: both nbins and bin_alg specified. Using nbins...")

  generate_plot(show=args.plot, savefile=args.plot_savefile)
  exit(0)
