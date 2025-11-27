"""
Calculates statistical information accross all subject using one representative curve per subject. 
outputs min, max, mean, confidence interval(95%), standard deviation

Usage: python avg_curve_stats.py <data_path> [--data_type, Default=All] [--new_file, Default=data_path] [--output_file]

See argparse for more options or python avg_curve_stats.py --help

Note: assumes curve data is stored in the format Subject, Type, Curve
Future improvements could have this handle any input file formatting (take column header as cmd line arg)
    - function to add this easily is in utils.py

Edit History:
  -- Nove 4, 2025: added docstrings and error-checking in functions
  -- Oct 28, 2025: add printing of data to output file
  -- Oct 27, 2025: Created, Erica Baldesarra

"""

from itertools import zip_longest
import os
from sqlite3 import SQLITE_CONSTRAINT_PRIMARYKEY
import numpy as np
import argparse
import pandas as pd
from ast import literal_eval
import scipy
import matplotlib.pyplot as plt
from openpyxl import load_workbook, Workbook

def calculate_curve_stats(curves, confidence_level: float = 0.95):
  """ Generates the min, max, mean, standard deviation, confidence intervals for the curves at each point

  Args:
      curves (array-like): Array of curve points (array of arrays)
      confidence_level (float): confidence level of confidence intervals calculated
        - default = 0.95 (95%)

  Returns:
      arrays for each statistic at each calculated point on the curves

  Requires: 
    curves all have the same length (same number of points)

  Raises:
    RuntimeError
  """

  if not all(len(curve) == len(curves[0]) for curve in curves):
    raise RuntimeError("Error, not all curves have the same length")

  cis = np.empty((0,2))
  curve_data = np.array(curves)
  curve_data = curve_data.T
  mins = curve_data.min(axis=1)
  means = np.mean(curve_data, axis=1)
  sds = np.std(curve_data, axis = 1)
  maxes = curve_data.max(axis=1)

  for curve in curve_data:
    data = np.array(curve)
    n = len(data)
    m, se = np.mean(data), scipy.stats.sem(data)
    h = se * scipy.stats.t.ppf((1 + confidence_level) / 2., n-1)
    cis = np.vstack([cis, [m-h, m+h]])

  #print(f"DEBUG: CI's: {cis}")

  return mins, maxes, means, sds, cis


def plot_mean_ci_curve(mean_data, cis):
  """plots data as single line and CI's as shaded region above/below each data point

  Args:
      mean_data (array-like): 'mean' data to be plotted
      cis (array-like): array of CI's for each point in mean_data

  Requires:
    len(cis) == len(mean_data)
    len(cis[i] == 2) for all i

  Raises:
    RuntimeError

  Returns:
    fig, ax = figure and axis created for plot 
  """
  # todo:add vert line at max

  if len(cis) != len(mean_data):
    raise RuntimeError("Error, mean_data and cis are of unequal length")
  elif not all(len(pair) == 2 for pair in cis):
    raise RuntimeError("Error, not all confidence intervals given have two values")

  fig, ax = plt.subplots()
  ax.plot(np.linspace(0, len(mean_data), len(mean_data)), mean_data)
  ax.fill_between(np.linspace(0, len(mean_data), len(mean_data)), cis.T[0], cis.T[1], color='b', alpha=.3)
  #plt.ylim(5, 30)
  return fig, ax

#todo: use function from curve_data_utils file
def write_line_excel(filename, write_data: list, row_id = None):
  """Writes stats outputs to excel file. Optional row_id will be added in first column if included

  Args:
      filename (path-like)): Name of excel file to write to or create (if doesn't exist)
      write_data (list): data to append (one line)
      row_id (Any): unique identifier for that row, to be appended in the first column
  """
  # Check if the file already exists
  if os.path.isfile(filename):
    print(f"Writing to (appending) existing file {filename}.")
    wb = load_workbook(filename)
    sheet = wb.active
  else:
    print(f"Writing to new file {filename}.")
    wb = Workbook()
    sheet = wb.active
    sheet["A1"] = "mins"
    sheet["B1"] = "maxes"
    sheet["C1"] = "means"
    sheet["D1"] = "standard_deviations"
    sheet["E1"] = "confidence_intervals"
    sheet['F1'] = "min_of_means"
    sheet['G1'] = "max_of_means"
    if row_id:
      sheet.insert_cols(0, 1)
      sheet['A1'] = row_id

  sheet.append(write_data)
  wb.save(filename)

if __name__ == '__main__':
  np.set_printoptions(legacy='1.25')
  parser = argparse.ArgumentParser()
  parser.add_argument("data_path", help="Path to subject curve data.")
  parser.add_argument("--data_type", default=None, help="Index data rows from the 'Type' column with this value. All rows are selected if this is not specified")
  parser.add_argument("--data_cols", default='Curve', help="Data columns to index. Default column header is 'Curve'")
  parser.add_argument("-p", "--plot", action="store_true", default=False, help="include flag to produce CI and mean plots")
  parser.add_argument("--plot_savefile", default = None, help="Filename to save plot to. No plot is saved if not provided.")
  parser.add_argument("--confidence_level", type=float, default=0.95)
  parser.add_argument("--output_file", default="outputs/curve_stats.xlsx", help="File to write output stats to. Default is outputs/curve_stats.xlsx. Set --nw or --no_write to have no output written")
  parser.add_argument("--nw", "--no_write", action='store_true', default=False)

  args = parser.parse_args()

  curve_data = pd.read_excel(args.data_path)
  if args.data_type:
    curve_data = curve_data[curve_data["Type"] == args.data_type]
  if args.data_cols:
    curve_data = curve_data[args.data_cols].to_numpy()

  curve_data = [literal_eval(curve) for curve in curve_data]

  mins, maxes, means, sds, cis = calculate_curve_stats(curve_data, args.confidence_level)

  if args.plot or args.plot_savefile:
    fig, ax = plot_mean_ci_curve(means, cis)
    for curve in curve_data:
      ax.plot(curve, '--', alpha=0.6, color='grey')
  
  if args.plot_savefile:
    plt.savefig(args.plot_savefile)
  
  if args.plot:
    plt.show()

  # print calculated values to xlsx file
  if not args.nw:
    line = [args.data_type, str(mins), str(maxes), str(means), str(sds), str(cis), str(min(means)), str(max(means))] if args.data_type else [str(mins), str(maxes), str(means), str(sds), str(cis), str(min(means)), str(max(means))]
    write_line_excel(args.output_file, line, 'Type') if args.data_type else write_line_excel(args.output_file, line)

  exit(0)



