WITH source_clients AS (
    SELECT
        _id AS id,
        first_name,
        last_name,
        email,
        phone,
        created_at,
        updated_at
    FROM 
        {{source('raw_translations','clients')}}
)

SELECT * FROM source_clients ORDER BY created_at DESC
