""" Utility module for the tmc_jcs repository

    last Modified: Sept 2025, Erica Baldesarra
"""

import numpy as np
import pandas as pd

movement_types = ['ABAD', 'KEY', 'OPP']

def read_scs_csv(csv_path):
  with open(csv_path, 'r') as f:
    scs = pd.read_csv(f, usecols = [1, 2, 3]).values
  
  return scs


def compute_jcs(mc1_scs, trp_scs):
  """
    Computes JCS from SCS based on Halilaj, et al. 2013.
    Requires MC1 and TRP .csv output with saddle points and x, y, z axes for SCS
    Returns e1, e2, e3 unit vectors for JCS where:

    e1 = z_trp
    e2 = e1 x e3 ('floating axis')
    e3 = x_mc1
  """
  e1 = trp_scs[3]
  e3 = mc1_scs[1]
  e2 = np.cross(e1,e3)

  return [e1, e2, e3]


def plot_angles(ax, angles, motion_type, frames = 60):
  x_values = np.arange(frames)
  ax.plot(x_values, angles)
  ax.set_xlabel('Frame')
  ax.set_ylabel(f'Angle Between MC1 and TRP ({motion_type}, Deg)')

  return ax

def plot_ROMs(plot, values, roms = 2):
  for rom in range(len(roms)):
    motion = rom + 1
    len_motion = roms[rom][1] - roms[rom][0] + 1
    plot(values[rom], range(len_motion), label=f"Angles through movement {motion}")
  
  return plot


