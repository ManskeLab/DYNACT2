""" hysteresis.py

Plot and calculate area of hysteresis using one motion cycle curve

Usage: python hysteresis_ind.py  <data_path> [--data_type, Default=All] [--data_cols] [--plot, -p] [--subject, Default = all] [--ss, --space_separated, default = False]

Edit History: 
  Nov 26, 2025: Edit hysteresis plot output style to be directional
  Oct 29, 2025: File Created - Erica Baldesarra

"""

import pandas as pd
import numpy as np
from ast import literal_eval
import hysteresis as hys
import matplotlib.pyplot as plt
import scipy.signal as sig
from scipy.integrate import trapezoid
from argparse_utils import create_parser_optionals
from curve_data_utils import read_data_file

def find_extrema(data: list | np.ndarray):
  """Find extrema with the maximum height in a data set

  Args:
      data (list | np.ndarray): data to find extrema

  Returns:
      _type_: _description_

  Note: incomplete, raises NotImplementedError
  """

  raise NotImplementedError

  if isinstance(data, list):
    data = np.array(data)

  maxima_peaks, maxima_props = sig.find_peaks(data)
  minima_peaks, minima_props = sig.find_peaks(data * -1)

  max_height_peak_idx = np.argmax(np.abs(data[maxima_peaks]))
  max_height = maxima_props['peak_heights'][max_height_peak_idx]

  min_height_peak_idx = np.argmax(minima_props['peak_heights'])
  min_height = minima_props['peak_heights'][min_height_peak_idx]

  if (max_height > min_height):
    return maxima_peaks[max_height_peak_idx]
  else:
    return minima_peaks[min_height_peak_idx]
  
def area_between_curves(y_up, y_down):
  """Calculate area between curves.

  Args:
      y_up (array_like, 1d): _description_
      y_down (array_like, 1d): _description_

  Returns:
      num: area between the two curves

  Requires:
    y_up and y_down have same number of points (assumed to be the same x-axis)
  
  Raises: AttributeError if input lengths are not the same
  """

  if len(y_up) != len(y_down):
    print("ERROR: unbalanced curve data")
    raise AttributeError
  y_diff = np.abs(np.array(y_up) - np.array(y_down))
  # Calculate the area using the trapezoidal rule
  return trapezoid(y_diff)

def create_hysteresis_plot(x_up: np.ndarray, x_down: np.ndarray, y_up: np.ndarray, y_down: np.ndarray):
  """Plot hysteresis with one inversion point

  Args:
      x_up (np.ndarray): x-values for the first direction
      x_down (np.ndarray): x_values for the second direction
      y_up (np.ndarray): y-values for the first direction
      y_down (np.ndarray): y-values for the second direction

  Returns (num, hys.Hysteresis): area between shared x-values for both directions, hysteresis object
  """
  def plot_arrows(ax: plt.Axes, x, y, num_arrows = 3):
    """Plots arrows along direction of plotted line. (evenly spaced within 25% and 75% of y-value range)

    Args:
        ax (plt.Axes): Axis to plot arrows along
        x (array-like): x-values for data to plot
        y (array-like): y-values for data to plot
        num_arrows (int, optional): Number of arrows along line to draw. Defaults to 3.
      
    Returns (plt.Axes): The newly annotated axis. Also edits axis in-place 
    """

    x = np.array(x)
    y = np.array(y)

    arrow_ids = np.linspace(int(len(x)/4), int(len(x)* (3/4)), num=num_arrows, dtype = int)
    u = np.diff(x)[arrow_ids]
    v = np.diff(y)[arrow_ids]
    pos_x = x[:-1][arrow_ids] + u/2
    pos_y = y[:-1][arrow_ids] + v/2
    norm = np.sqrt(u**2+v**2)

    ax.quiver(pos_x, pos_y, u/norm, v/norm, angles="xy", zorder=5, pivot="mid")
    return ax

  xy_data = np.column_stack([np.concatenate((x_up, x_down)), np.concatenate((y_up, y_down))])
  hys_data = hys.Hysteresis(xy_data)
  fig, ax = hys_data.initFig()

  (x_fill, y_common_up, y_common_down) = (x_up, y_up, y_down[x_up][::-1]) if len(x_up) < len(x_down) \
    else (x_down[::-1], y_up[x_down[::-1]], y_down[::-1])

  common_area = area_between_curves(y_common_up, y_common_down)

  ax.fill_between(x_fill,
                  y_common_up, 
                  y_common_down, 
                  color='gray', alpha=0.5, label=f"Hysteresis Area = {common_area:.2f}")
  hys_data.plot(showReversals = True)
  plt.plot(x_up, y_up, color="black", label="Start -> Extreme")
  plt.plot(x_down, y_down, color="red", label="Return")

  plot_arrows(ax, x_up, y_up)
  plot_arrows(ax, x_down, y_down)
  
  plt.legend()
  plt.grid()
  return common_area, hys_data

if __name__ == '__main__':
  parser = create_parser_optionals()
  parser.add_argument("data_path", help="Path to curve data to plot as hysteresis")
  parser.add_argument("--space_separated", '--ss', action='store_true', default=False, 
                      help="enable if data in excel file is space-separated instead of comma delineated")
  parser.add_argument("--inversion_point", default=None, help="If known/desired, use input inversion type instead of finding peak to invert at.", type=int)

  args = parser.parse_args()

  curve_data = read_data_file(args.data_path, args.data_cols, args.data_type, index_col=0)

  if args.subject:
    curve_data = curve_data[curve_data["Subject"] == args.subject]

  if args.space_separated:
    curve_data_y = curve_data.strip('[]').split()
    curve_data_y = [literal_eval(point) for point in curve_data_y]
  else:
    curve_data_y = literal_eval(curve_data)
  
  # future improvement: add function to automatically choose inversion point (non-trivial if non-positive non-quadratic )
  flip_index = args.inversion_point

  curve_data_x_up = np.linspace(0, flip_index, flip_index + 1, dtype=int)
  curve_data_x_down = np.linspace(flip_index, 2 * flip_index -  len(curve_data_y) + 1, len(curve_data_y) - (flip_index), dtype=int)
  
  curve_data_y_up = curve_data_y[:flip_index + 1]
  curve_data_y_down = curve_data_y[flip_index:]
  
  if args.plot or args.plot_savefile:
    common_area, _ = create_hysteresis_plot(curve_data_x_up, 
                                                    curve_data_x_down, 
                                                    np.array(curve_data_y_up), 
                                                    np.array(curve_data_y_down))
  
  if args.plot_savefile:
    if args.verbose >=1:
      print(f"Saving plot to file {args.plot_savefile}")
    plt.savefig(args.plot_savefile)

  if args.plot:
    plt.show()

  print(f"Area of hysteresis for {args.data_type}: {common_area:.5f}")

  exit(0)