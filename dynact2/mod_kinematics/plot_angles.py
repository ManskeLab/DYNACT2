"""
Plot joint angles per motion type (AbAd, FlexExt, Rot)

  Edit History:
    Nov 21, 2025: Subclass plotting to newly added plot_utils file - Erica Baldesarra
    Nov 21, 2025: Utilize argparse_utils to create parser - Erica Baldesarra
"""
from curve_data_utils import read_data_file
import matplotlib.pyplot as plt
import argparse
import pandas as pd
import os
import numpy as np
from constants import angle_dirs, motions
from argparse_utils import create_parser_optionals
from ast import literal_eval

def plot_multiple_curves(curve_data_fp: str | os.PathLike, data_cols = None, extra_points= None):
  """Plot multiple curves as side-by-side figures, optionally including point overlays

  Args:
      curve_data_fp (str | os.PathLike): path to curve data file.
      data_cols (list, optional): Columns to index from data file. Defaults to all.
      extra_points (list(num), optional): List of extra points (x-values) to plot overtop of curves. Defaults to None.

  Note: extra points will be plotted on all figures.
  """
  
  try:
    curve_data = read_data_file(curve_data_fp)
  except Exception as e:
    print(f"ERROR opening curve data file {curve_data_fp}: ")
    print(e)
  
  data_cols = curve_data.columns.values.tolist() if not data_cols else data_cols
  fig, axs = plt.subplots(1, len(data_cols))

  for index, column in enumerate(data_cols):
    curve_values = curve_data[column].values
    axs[index].plot(np.arange(1, len(curve_values) + 1), curve_values, label=column)

    for point in extra_points:
      axs[index].plot(point, curve_values[point], 'or')

    axs[index].grid()

  fig.tight_layout()
  fig.set_figwidth(12)
  plt.subplots_adjust(wspace=0.3)

if __name__ == "__main__":
  parser = argparse.ArgumentParser(
                    prog='Plot angles')
  parser = create_parser_optionals(parser)
  parser.add_argument("angle_filepath", help="Path to the angle data to print")
  parser.add_argument("--extra_points", default=None, help="String representation of a list of extra points to plot on the diagrams")

  args = parser.parse_args()
  args.extra_points = literal_eval(args.extra_points)

  plot_multiple_curves(args.angle_filepath, angle_dirs, args.extra_points)
  if args.plot_savefile:
    plt.savefig(args.plot_savefile)
  if args.plot:
    plt.show()




