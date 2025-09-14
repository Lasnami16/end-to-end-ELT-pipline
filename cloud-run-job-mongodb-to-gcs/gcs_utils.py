from google.cloud import storage
import logging
import os

logging.basicConfig(level=logging.INFO)

def get_gcs_client():
    credentials_path = os.getenv("GOOGLE_APPLICATION_CREDENTIALS")
    if credentials_path and os.path.exists(credentials_path):
        logging.info(f"Using service account credentials from {credentials_path}")
        return storage.Client.from_service_account_json(credentials_path)
    else:
        logging.info("Using Application Default Credentials (ADC)")
        return storage.Client()

def upload_json_to_gcs(
    bucket_name: str,
    json_string: str,
    destination_blob_name: str,
    folder: str = "translations"
) -> None:
    """
    Uploads a JSON string directly to a Google Cloud Storage bucket using service account credentials or ADC.

    Args:
        bucket_name (str): The name of the GCS bucket.
        json_string (str): The JSON content as a string.
        destination_blob_name (str): The destination file name in GCS (e.g., 'clients.json').
        folder (str): Optional folder path inside the bucket (default is 'translations').

    Returns:
        None
    """
    try:
        client = get_gcs_client()
        bucket = client.bucket(bucket_name)
        blob_path = f"{destination_blob_name}"
        blob = bucket.blob(blob_path)

        blob.upload_from_string(json_string, content_type='application/json')
        logging.info(f"Uploaded JSON string to gs://{bucket_name}/{blob_path}")

    except Exception as e:
        logging.error(f"Error uploading JSON to GCS: {e}", exc_info=True)
