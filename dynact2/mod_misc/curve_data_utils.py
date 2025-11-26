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
from openpyxl import Workbook, load_workbook

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

def get_motion_cycle_frames(motion_frames: pd.DataFrame, motion_cycles: list[int]):
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

def read_data_file(file_path, columns: list[str] | str = None, rows: list[str] | str = None) -> pd.DataFrame:
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
    raise FileExistsError(f"Cannot open file {file_path}")

  if os.path.splitext(file_path)[-1].lower() in [".xls", ".xlsx", ".xlsm", ".xlsb", ".odf", ".ods" ".odt"]:
    # pandas accepted file extensions for read_excel
    data_all = pd.read_excel(file_path)
  else:
    # any comma-separated file can be read. Otherwise panda will throw its own error
    try: 
      data_all = pd.read_csv(file_path)
    except Exception as e:
      print(f"Exception reading from data file {file_path}:")
      print(e)
      raise
  
  data_frame = data_all
  if rows:
    row_accessor = data_frame.transpose()
    row_accessor = row_accessor[rows]
    data_frame = row_accessor.transpose()
  
  if columns:
    data_frame = data_frame[columns]

  return data_frame

def write_to_excel(file_path: str | os.PathLike, data_rows: list | np.ndarray, column_headers = None) -> None:
  """Write data rows to excel, optionally set column headers

  Args:
      file_path (str | os.PathLike): Path to excel file. Created if does not exist
      data_rows (list | np.ndarray): List which each element is a row of data to be written
      column_headers (list, optional): Column header values to insert. Defaults to None.
  """
  # Check if the file already exists
  if os.path.isfile(file_path):
    print(f"Writing to (appending) existing file {file_path}.")
    wb = load_workbook(file_path)
    sheet = wb.active
  else:
    print(f"Writing to new file {file_path}.")
    wb = Workbook()
    sheet = wb.active

  if column_headers:
    for col_num, header_text in enumerate(column_headers, 1):
      sheet.cell(row=1, column=col_num, value=header_text)

  for row_data in data_rows:
    sheet.append(row_data)
  
  wb.save(file_path)
  return

def extract_data(frame_idx: int, data_file: str | os.PathLike, data_cols: list[str] | str = None):
  """Extract a row of data pertaining to a frame

  Args:
      frame_idx (int): row index for frame data
      data_file (str | os.PathLike, optional): File path to data file. Defaults to None.
      data_cols (list[str] | str, optional): Columns to extract data from. Defaults to all.

  Returns:
      _type_: _description_
  """
  data = None
  if data_file and data_cols:
    data = read_data_file(data_file, columns = data_cols, rows = [frame_idx])
  else:
    data = read_data_file(data_file, rows = [frame_idx])

  return data