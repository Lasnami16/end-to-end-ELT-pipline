from mongodb_utils import export_collections_to_gcs

if __name__ == "__main__":
    collections_to_export = ["translations", "documents", "clients"]
    export_collections_to_gcs(collections_to_export)




