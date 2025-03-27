{{
 config(
  materialized='incremental',
  unique_key='id',
  on_schema_change='sync_all_columns',
  partition_by={
    "field": "payment_at",
    "data_type": "timestamp",
    "granularity": "day"
  }
 )
}}

WITH exploded_payments AS (
    SELECT 
        -- Generate a new unique key
        CONCAT(_id, "-", FORMAT_TIMESTAMP('%Y%m%d%H%M%S', COALESCE(p.created_at, TIMESTAMP('1970-01-01')))) AS id,
        _id AS translation_id,
        p.price,
        p.created_at AS payment_at
    FROM 
        {{ source('raw_translations', 'translations') }}, 
        UNNEST(payments) AS p
    
    -- Apply incremental logic to only process new/updated rows
    {% if is_incremental() %}
    WHERE p.created_at > COALESCE(
        (SELECT MAX(payment_at) FROM {{ this }}), 
        TIMESTAMP('1970-01-01')
    )
    {% endif %}
)

SELECT * FROM exploded_payments
