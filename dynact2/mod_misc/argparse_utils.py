"""
  Custom argument parser with functionality shared accross modules

  Edit History:
  - Nov 21: Add input and output file paths and directory options - Erica Baldesarra
  - Nov 18: Creation - Erica Baldesarra

"""

import argparse

def create_parser_optionals(parser: argparse.ArgumentParser = None) -> argparse.ArgumentParser:
  """Add optional arguments to parser

  Args:
      parser (argparse.ArgumentParser, optional): Add optionals to existing parser. Defaults to None.

  Returns:
      argparse.ArgumentParser: parser with optional arguments defined
  """
  parser = parser if parser else argparse.ArgumentParser()
  
  # data indexing args
  parser.add_argument("--input_filepath", help="Path to input data")
  parser.add_argument("--input_dir", help="path to data input directory. Assumes some file structure/naming convention or uses argument input_filename")
  parser.add_argument("--input_filename", help="Name of file for input data. Used in conjunction with --input_dir")
  parser.add_argument("--subject", type=int, help="Subject to identify") 
  parser.add_argument("--data_type", default=None, help="Index data rows from the 'Type' column with this value. All rows are selected if this is not specified")
  parser.add_argument('--data_rows', default=None, help="Data rows to index. Defaults to all rows")
  parser.add_argument("--data_cols", default=None, help="Data columns to index. Defaults to all columns")

  # visualization/output args
  parser.add_argument("-p", "--plot", action="store_true", default=False, help="Include flag to produce plots")
  parser.add_argument("--plot_savefile", default = None, help="Filename to save plot to. No plot is saved if not provided.")
  parser.add_argument("--output_file", default="outputs/out_data.xlsx", help="File (full path) to write output stats to. Set --nw or --no_write to have no output written")
  parser.add_argument("--nw", "--no_write", action='store_true', default=False, help='Flag to disable writing any data output to files')
  parser.add_argument("--output_dir", default="outputs/", help="Output directory to put output files in.")

  # calculation-related
  parser.add_argument("--frames", type = int, default=60, help="Number of frames to analyze")
  parser.add_argument("--max_of", default='min', type=str, help="String representing which calculation to compute frame. Default=min. Options=min, mean/avg, max")
  parser.add_argument("--motion_frames", help="File path to identified motion frames of subject")

  parser.add_argument('-d', '--debug', action='store_true', default=False)
  parser.add_argument('-v', '--verbose', action='count', default=0)

  return parser
