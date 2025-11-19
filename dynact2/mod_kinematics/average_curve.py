"""
average_curve.py

This script extracts motion curve data for a sibject over all motions, smooths to a unanimous number of points, and creates an average representative curve. Outputs data to xlsx file in form Subject, data_type, avg_curve

Usage: 
  python average_curve.py <subject> <path_to_motion_frames> <path_to_motion_data.csv> [--points=interp_points] [--data_type=data_type] [--plot] [--debug]

  Args:
    - subject (int): subject ID 
    - path_to_motion_frames.csv (path-like): a excel file of the format Subject, Start_i, Extreme_i, End_i,...,tot_useable,motion_cycles, where
        tot_useable = # of acceptable motions
        motion_cycles = list of ids of acceptable motions 
    - path_to_motion_data (path-like): file containing the data for each frame of the subject (eg joint angles, stress...)
    - [optional] points (int): # of points in the averaged curve (interpolates original curves)
      default = max number of points from input curves
    - [optional] data_type (str): type of data for curve. 
      default = 'data'
    - [optional, flag] -p (bool): displays a plot of the average curve, [todo: with 95% confidence interval shaded]
      default = False

  Output:
    - an average curve representing
    - prints (appends) this curve data to output_file

Edit History:
  -- 10-27-2025: add output_file arg, Erica Baldesarra
  -- 10-24-2025: Created file, setup arg parsing, Erica Baldesarra

"""

import argparse
import os
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
from statistics import mean
from itertools import zip_longest
from curve_data_utils import interpolate_curve, get_motion_cycles, read_data_file
from openpyxl import load_workbook, Workbook
from ast import literal_eval

debug = False

def get_curve_average(curves):
  """
  Generates an average curve representing all of the curves

  Args:
      curves (list of lists): list of all curves to average over

  Returns:
      array_like: average of all curves in 'curves'
  """
  # get average of all curves at each frame point
  avg_curve = []
  for i, curve in enumerate(zip_longest(*curves)):
    frame_avg = mean(filter(lambda x: x is not None, curve))
    if debug:
      print(f"DEBUG: Avg curve at point {i+1}: {frame_avg}")
    avg_curve.append(frame_avg)
  
  return avg_curve

if __name__ == '__main__':
  np.set_printoptions(legacy='1.25')
  parser = argparse.ArgumentParser()
  parser.add_argument("subject", type=int, help="Subject ID")
  parser.add_argument("motion_frames_path", help = "Path to motion frame identifying excel file.")
  parser.add_argument("motion_data_path", help = "Path to motion data excel/csv file.")
  parser.add_argument("--points", type = int, help = "Number of points to 'resample' data to.", default = 100)
  parser.add_argument("--data_cols", help = "Data columns to extract. Can be a single column or list of columns", default = None)
  parser.add_argument('--plot', action='store_true', default=False)
  parser.add_argument("-d",'--debug', action='store_true', default=False)
  parser.add_argument('--output_file', default='outputs/avg_motion_curves.xlsx')
  parser.add_argument('--plot_savefile', default='outputs/avg_curve.png')
  parser.add_argument('--nw', '--no_write', action='store_true', help="Set to true for no writing of results")

  args = parser.parse_args()
  debug = args.debug

  # parse motion cycle frame indices from the frame_id file
  motion_cycles, motion_frame_def = get_motion_cycles(pd.read_excel(args.motion_frames_path), args.subject)
  if debug:
    print(f"DEBUG motion_cycles: {motion_cycles}, motion frames: {motion_frame_def}")

  subject_data = read_data_file(args.motion_data_path, columns = args.data_cols)

  if debug:
    print(f"DEBUG: subject_data: \n{subject_data}")

  # extract motion cycle curves
  cycles = []
  for (start, extreme, end) in motion_frame_def:
    cycles.append(subject_data[start-1:end])
  
  if debug:
    print(f"DEBUG: cycles: \n{cycles}")

  # interpolate cycles linearly and resample to unanimous x-range
  interpolated_cycles = []
  for cycle in cycles:
    interp_cycle = interpolate_curve(cycle, 1, args.points)
    interpolated_cycles.append(interp_cycle)

  avg_curve = get_curve_average(interpolated_cycles)

  if args.plot or args.plot_savefile:
    # plot all curves along with average on same plot
    # todo: add better visualization method
    for curve in interpolated_cycles:
      plt.plot(curve)
    plt.plot(avg_curve, 'r--')
    plt.grid()
    if args.plot_savefile:
      plt.savefig(args.plot_savefile)
    if args.plot:
      plt.show()
  
  print(f"Average Curve: ")
  print(avg_curve)

  if not args.nw:
    if os.path.isfile(args.output_file):
      # print avg curve to workbook in format subject, angle_direction(ie data_type), avg_curve
      wb = load_workbook(args.output_file)
      # Select First Worksheet
      ws = wb.worksheets[0]
    else:
      wb = Workbook()
      ws = wb.active
      ws["A1"] = "subject"
      ws["B1"] = "curve_data"

    ws.append([args.subject, str(avg_curve)])
    wb.save(args.output_file)

  exit(0)

