{{
 config(
  materialized='incremental',
  unique_key='translation_id',
  on_schema_change='sync_all_columns',
  partition_by={
    "field": "created_at",
    "data_type": "timestamp",
    "granularity": "day"
  },
  cluster_by=["client_id"]  
 )
}}

WITH source_translations AS (
    SELECT 
        _id AS translation_id,
        client_id,
        work_status,
        payment_status,
        discount,
        total_without_discount,
        total,
        rest,
        payment,
        created_at,
        updated_at
    FROM 
        {{ source('raw_translations', 'translations') }}
    
    {% if is_incremental() %}
    WHERE updated_at > COALESCE(
        (SELECT SAFE_CAST(MAX(updated_at) AS timestamp) FROM {{ this }}), 
        TIMESTAMP('1970-01-01') 
    )
    {% endif %}
)

SELECT * FROM source_translations
