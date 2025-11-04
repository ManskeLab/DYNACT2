"""
Utilities file for kinematic data processing

Edit History: 
  - Nov 4, 2025, added read_data_file function, Erica Baldesarra
  - Oct 24, 2025, file creation, Erica Baldesarra

"""
import numpy as np
import pandas as pd
from scipy.interpolate import make_interp_spline
from ast import literal_eval
import os

def interpolate_curve(data, degree: int, points: int, x_offset = 0):
  """Interpolate curve data using a spline, at specifc points (assuming data points x starts at x_offset)

  Args:
      data (array_like): data curve to interpolate
      degree (int): interpolation spline degree
      points (int): number of points in output curve
      x_offset (num) [optional]:  

  Returns:
      array_like: y-data of interpolated curve
  """
  data_spline = make_interp_spline(np.arange(len(data)), data, degree)
  interp_curve = data_spline(np.linspace(x_offset, len(data) + x_offset, num=points))

  return interp_curve

def get_motion_cycle_frames(motion_frames: pd.DataFrame, motion_cycles):
  """Extract start, extreme and end frames for the motion cycles

  Args:
      motion_frames (pandas.DataFrame): dataframe with frame data for start, extreme and end of motions
      motion_cycles (list[int]): list of motion cycle indices to parse

  Returns:
      list[(int,int,int)]: list of start,extreme,end tuples for motion frames
  """
  motion_definitions = []
  for cycle in motion_cycles:
    start = int(motion_frames[f'Start_{cycle}'].to_numpy()[0])
    extreme = int(motion_frames[f'Extreme_{cycle}'].to_numpy()[0])
    end = int(motion_frames[f'End_{cycle}'].to_numpy()[0])
    motion_definitions.append((start, extreme, end))
  
  return motion_definitions


def get_motion_cycles(motion_frames: pd.DataFrame, subject: int):
  """Get motion_cycles list from excel file

  Requires: motion_frames has header 'motion_cycles'

  Args:
      motion_frames (pandas.DataFrame): data_frame with motion frame data
      subject (int): subject ID

  Returns:
      motion_cycles: List of motion cycle indices
      motion_definitions: list of start, extreme, ends for acceptable motions
  """

  motion_frames = motion_frames.head(15)
  motion_frames = motion_frames.loc[(motion_frames['Subject'] == subject)]
  motion_cycles = literal_eval(motion_frames['motion_cycles'].to_numpy()[0])

  motion_definitions = get_motion_cycle_frames(motion_frames, motion_cycles)

  return motion_cycles, motion_definitions

def read_data_file(file_path, columns: list[str], rows: list[str]) -> pd.DataFrame:
  """Reads string-indexed data from excel or csv file

  Args:
      file_path (str | Path): path to file with data
      columns (list[str]): list of strings naming columns to select
      rows (list[str]): list of strings naming rows to select

  Raises:
      FileExistsError: if file name provided does not exist

  Returns:
      pd.DataFrame: data frame containing the data for all columns and rows. 

  Note: data is not converted to a numpy array before return
  """
  if not os.path.exists(file_path):
    raise FileExistsError

  elif os.path.splitext(file_path)[-1].lower() in ["xls", "xlsx", "xlsm", "xlsb", "odf", "ods" "odt"]:
    # pandas accepted file extensions for read_excel
    data_all = pd.read_excel(file_path)
  else:
    # any comma-separated file can be read. Otherwise panda will throw its own error
    data_all = pd.read_csv(file_path)

  data_frame = data_all[columns]
  row_accessor = data_frame.transpose()
  row_accessor = row_accessor[rows]
  data_frame = row_accessor.transpose()
  return data_frame