"""
  Analyze data convergence for mesh face result values (stress was used as framework)

  Usage: Analyze_mesh_cvg.py <input_dir> <mesh_range> <face_data_fn> [-p, --plot] [--plot_savefile] [--data_cols] [--data_rows]

  Analyzes max face data, mean face data, SD of face data, (todo: distributions (i.e. histograms) and heatmaps)

  Edit History: 
    - 2025-12-09: File Creation - Erica Baldesarra
"""

import argparse
from argparse_utils import create_parser_optionals
import os
from curve_data_utils import read_data_file, generate_plot
import numpy as np
import matplotlib.pyplot as plt

if __name__ == "__main__":
  parser = argparse.ArgumentParser()
  parser.add_argument("--mesh_range", nargs='+', type=int, help="Inputs in the same style as 'range' accepts for the mesh size numbers. Will be used to index directories under --input_dir")
  parser.add_argument("--face_data_fn", nargs=1, help="Name of data file to analyze. Within '--input_dir/mesh_size/'")
  parser = create_parser_optionals(parser)

  args = parser.parse_args()

  means = []
  maxes = []
  sds = []
  for vertices in range(*args.mesh_range):
    if args.verbose >= 1 or args.debug:
      print(f"Processing case {vertices}...")
    data_fp = os.path.join(args.input_dir, str(vertices), args.face_data_fn[0])
    face_data = read_data_file(data_fp, args.data_cols, args.data_rows).to_numpy()

    means.append(np.mean(face_data))
    maxes.append(np.mean(face_data))
    sds.append(np.std(face_data))

  # future improvements: add noise smoothing

  plt.plot(range(*args.mesh_range), means, label = "Mean")
  generate_plot(args.plot, args.plot_savefile)
  plt.clf()
  plt.plot(range(*args.mesh_range), maxes, label = "Max")
  generate_plot(args.plot, args.plot_savefile)
  plt.clf()
  plt.plot(range(*args.mesh_range), sds, label = "Std Dev")
  generate_plot(args.plot, args.plot_savefile)
  plt.clf()

