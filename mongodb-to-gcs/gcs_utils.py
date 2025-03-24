def upload_object_to_bucket(bucket_name, source_file, destination_blob_name, service_account_file):
    from google.cloud import storage
    
    """
    Uploads a file to a GCS bucket under the 'translations/' subdirectory.

    bucket_name (str): Name of the GCS bucket.
    source_file (str): Local file path to be uploaded.
    destination_blob_name (str): File name in GCS (without 'translations/').
    service_account_file (str): Path to your service account JSON key file.
    """

    try:
        # Initialize a GCS client
        client = storage.Client.from_service_account_json(service_account_file)

        # Get a reference to the target GCS bucket
        bucket = client.bucket(bucket_name)

        # Construct the final GCS path under 'translations/' subdirectory
        blob_path = f"translations/{destination_blob_name}"

        # Upload the local file to GCS
        blob = bucket.blob(blob_path)
        blob.upload_from_filename(source_file)

        print(f'File {source_file} uploaded to {bucket_name}/{blob_path}')
    
    except Exception as e:
        print(f'Error uploading file: {str(e)}')
