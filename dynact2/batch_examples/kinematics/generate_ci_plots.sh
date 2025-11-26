#!/bin/bash
# script to print averaged curves of joint angles in healthy subjects
# adjust output_file as needed

for motion in 'abad' 'key' 'opp'; do
  for direction in 'AbAd' 'FlexExt' 'Rot'; do
    python avg_curve_stats.py "/Users/ericabaldesarra/Library/CloudStorage/OneDrive-UniversityofCalgary(2)/DYNACT/kinematics/outputs/avg_motion_curves_${motion}.xlsx" --data_type=$direction -p --nw --plot_savefile="/Users/ericabaldesarra/Library/CloudStorage/OneDrive-UniversityofCalgary(2)/DYNACT/kinematics/outputs/overall_mean_ci_plots/${motion}/${direction}_subject_traces.png"
  done
done
