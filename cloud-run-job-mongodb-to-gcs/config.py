import os
from dotenv import load_dotenv
from typing import Optional

# Load environment variables from .env file
load_dotenv()

# MongoDB connection string
MONGODB_CONNECTION: Optional[str] = os.getenv("MONGODB_CONNECTION")

# GCS configuration
GCS_BUCKET_NAME: Optional[str] = os.getenv("GCS_BUCKET_NAME")
GCS_FOLDER: str = os.getenv("GCS_FOLDER", "translations")  # Default folder if not specified

# Optional: Raise error if critical variables are missing
if not MONGODB_CONNECTION:
    raise ValueError("Environment variable MONGODB_CONNECTION is not set.")

if not GCS_BUCKET_NAME:
    raise ValueError("Environment variable GCS_BUCKET_NAME is not set.")
