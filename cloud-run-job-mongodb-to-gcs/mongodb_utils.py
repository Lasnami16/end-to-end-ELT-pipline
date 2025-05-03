import json
import logging
from datetime import datetime
from typing import Any, List

from pymongo import MongoClient
from bson import ObjectId

from config import MONGODB_CONNECTION, GCS_BUCKET_NAME, GCS_FOLDER, GCP_CREDENTIALS_PATH
from gcs_utils import upload_json_to_gcs

logging.basicConfig(level=logging.INFO)

def get_mongo_client() -> MongoClient:
    """
    Creates and returns a MongoDB client instance.

    Returns:
        MongoClient: A MongoDB client connected to the given connection string.
    """
    return MongoClient(MONGODB_CONNECTION)


def get_database(db_name: str = "translation") -> Any:
    """
    Returns the specified MongoDB database.

    Args:
        db_name (str): Name of the database (default is "translation").

    Returns:
        Database: A MongoDB database instance.
    """
    client = get_mongo_client()
    return client[db_name]


class MongoJSONEncoder(json.JSONEncoder):
    """
    Custom JSON encoder for MongoDB documents to handle ObjectId and datetime.
    """
    def default(self, obj: Any) -> Any:
        if isinstance(obj, ObjectId):
            return str(obj)
        elif isinstance(obj, datetime):
            return obj.strftime("%Y-%m-%d %H:%M:%S")
        return super().default(obj)


def fetch_collection_data(collection_name: str, db_name: str = "translation") -> str:
    """
    Fetches all documents from a MongoDB collection and returns them in NDJSON format.

    Args:
        collection_name (str): The name of the collection to fetch.
        db_name (str): The name of the database (default is "translation").

    Returns:
        str: The collection data serialized as newline-delimited JSON.
    """
    db = get_database(db_name)
    collection = db[collection_name]
    documents = collection.find()

    ndjson_data = "\n".join(
        json.dumps(doc, ensure_ascii=False, cls=MongoJSONEncoder)
        for doc in documents
    )

    logging.info(f"Fetched {collection.count_documents({})} documents from '{collection_name}' collection.")
    return ndjson_data


def export_collections_to_gcs(
    collection_names: List[str],
    bucket_name: str = GCS_BUCKET_NAME,
    destination_folder: str = GCS_FOLDER,
    service_account_file: str = GCP_CREDENTIALS_PATH
) -> None:
    """
    Fetch data from MongoDB collections and upload them to GCS as JSON files.

    Args:
        collection_names (List[str]): List of MongoDB collection names to export.
        bucket_name (str): GCS bucket name.
        destination_folder (str): Folder path inside the bucket.
        service_account_file (str): Path to GCP service account key.
    """
    for collection_name in collection_names:
        logging.info(f"Exporting collection '{collection_name}'...")

        json_data = fetch_collection_data(collection_name)
        blob_name = f"{destination_folder}/{collection_name}.json"

        upload_json_to_gcs(
            bucket_name=bucket_name,
            json_string=json_data,
            destination_blob_name=blob_name,
            service_account_file=service_account_file
        )

        logging.info(f"Successfully exported '{collection_name}' to GCS.")