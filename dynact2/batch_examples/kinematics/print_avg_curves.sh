#!/bin/bash
# script to print averaged curves of joint angles in healthy subjects
# adjust output_file as needed
# included as an example, create .sh scripts or run from command-line as needed 

for subject in {200..214}; do
  for motion in 'abad' 'key' 'opp'; do
    for direction in 'AbAd' 'FlexExt' 'Rot'; do
      python scripts/average_curve.py $subject angle_motion_frames.xlsx outputs/motion_angles/${subject}_${motion}_angles_deg.csv --points=100  --plot --data_type=$direction --output_file=outputs/${motion}/avg_motion_curves.xlsx
    done
  done
done