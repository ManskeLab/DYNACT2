import os
import pandas as pd

filepath = "/Users/manskelab/Desktop/"
filename = "206_logs.log"

file = os.path.join(filepath, filename)
df = pd.read_csv(file)

df.reset_index(inplace=True)

columns = ["model", "motion", "bone", "frame", "result", "start_intensity", "end_intensity", "sampling_percentage", "dilation_kernel_1", "dilation_kernel_2", "dilation_kernel_3"]
df.columns = columns

df['error'] = abs((df['start_intensity'] - df['end_intensity'])/df['start_intensity'])

def process_data(df):
    processed_data = []

    # Group by frame to handle attempts within each frame
    grouped = df.groupby(['frame', 'motion', 'bone'])

    for frame, group in grouped:
        fail_count = 0
        min_error_row = None

        for index, row in group.iterrows():
            if row['result'] == 'Success':
                # If success, add to processed_data and break the loop for this frame
                processed_data.append(row)
                break
            else:
                # If fail, update max_end_intensity_row if necessary
                fail_count += 1
                if min_error_row is None or row['error'] > min_error_row['error']:
                    min_error_row = row

                if fail_count >= 9:
                    # If failed 9 times, add the row with the highest end_intensity and break the loop for this frame
                    processed_data.append(min_error_row)
                    break
        else:
            # If no success row was found, add the row with the highest end_intensity if failed less than 9 times
            if min_error_row is not None:
                processed_data.append(min_error_row)

    return pd.DataFrame(processed_data)

# Process the data
processed_df = process_data(df)
output_file = 'processed_data.xlsx'
processed_df.to_excel(os.path.join(filepath, output_file), index=False)

