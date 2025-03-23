# end-to-end-ELT-pipline
This project is an end to end ELT pipline which extract the data from mongodb Atlas cluster, load the raw data as json (three collections) to a GCS bucket, load the raw data to BigQuery staging layer and then transform the raw data to exploitabale data marts using DBT
