import os
from google.cloud import storage
from mongodb_utils import fetch_collection
from mongodb_utils import save_json_to_file
from gcs_utils import upload_object_to_bucket
from config import GCS_BUCKET_NAME, GCS_FOLDER


if __name__ == "__main__":
    collections = ['translations','documents','clients']
    for c in collections:
        collection_data = fetch_collection(c)
        # Generate a unique file name per collection
        local_file_name = f"{c}.json"
         # Define local path for saving JSON
        local_directory = os.path.join(os.getcwd(), "exported_data")  # Save in 'exported_data/' folder
        os.makedirs(local_directory, exist_ok=True)  # Ensure directory exists
        local_file_path = os.path.join(local_directory, local_file_name)

        # Save JSON data to a file
        save_json_to_file(collection_data, local_file_path)

        # Upload to GCS under 'translations/{collection_name}.json'
        upload_object_to_bucket(GCS_BUCKET_NAME, local_file_path, f"{c}.json", 'credentials.json')
            
    
