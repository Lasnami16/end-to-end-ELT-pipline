import json
from pymongo import MongoClient
from datetime import datetime
from bson import ObjectId
from config import MONGODB_CONNECTION

def get_mongodb():
    """Return MongoDB client and database."""
    client = MongoClient(MONGODB_CONNECTION)
    db = client.translation  # Change to your database name
    return db

class MongoJSONEncoder(json.JSONEncoder):
    """Convert ObjectId and datetime to JSON-compatible format."""
    def default(self, obj):
        if isinstance(obj, ObjectId):
            return str(obj)  # Convert ObjectId to string
        elif isinstance(obj, datetime):
            return obj.strftime("%Y-%m-%d %H:%M:%S")  # Convert datetime to string
        return super().default(obj)

def fetch_collection(collection_name):
    db = get_mongodb()
    collection = db[collection_name]
    
    # Fetch all documents from the collection
    cursor = collection.find()
    
    # Convert each MongoDB document to JSON and save in NDJSON format
    json_data = ""
    for document in cursor:
        json_data += json.dumps(document, ensure_ascii=False, cls=MongoJSONEncoder) + "\n"
    
    return json_data

def save_json_to_file(json_data, file_path):
    """Save JSON data to a local file."""
    with open(file_path, "w", encoding="utf-8") as f:
        f.write(json_data)
    print(f"JSON data saved to {file_path}")
