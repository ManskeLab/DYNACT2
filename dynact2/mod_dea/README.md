# JSW Analysis Workflow

1. Use <code>identify_neutral_frames.py</code> to find the frame with the frame with the maximum JSW. 
  - Need excel file with JSW values per face of the MC1 (computed from dea_preprocess.py using ray-tracing)
  - 'maximum JSW' refers to the maximum of some summarized value from all of the faces of the frame. The script allows for this summary to be the min, max or mean of all face JSW values
2. Use <code>../mod_kinematics/average_curve.py</code> along with a excel file identifying the start, extreme and end frames of a single motion cycle to get an average representative curve per subject (see <code>../mod_misc/curve_utils.py</code>)

3. Use <code>../mod_kinematics/avg_curve_stats.py</code> to generate mean curve plots with confidence intervals