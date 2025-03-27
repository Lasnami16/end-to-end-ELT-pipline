with source_documents AS (
    SELECT
        _id AS id,
        name AS document_name,
        description AS document_description,
        created_at,
        updated_at
    FROM 
        {{source('raw_translations','documents')}}
)

SELECT * FROM source_documents ORDER BY created_at DESC
