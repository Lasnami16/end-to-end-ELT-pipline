import os
from dotenv import load_dotenv

load_dotenv()

MONGODB_CONNECTION = os.getenv("MONGODB_CONNECTION")
GCS_BUCKET_NAME = os.getenv("GCS_BUCKET_NAME")
GCS_FOLDER = "translations"