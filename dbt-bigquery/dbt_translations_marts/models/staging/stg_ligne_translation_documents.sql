{{
  config(
    materialized='table',
    cluster_by=['document_id', 'language']  
  )
}}

WITH translation_source AS (
    SELECT
        GENERATE_UUID() AS id,
        _id AS translation_id,
        d.document_id,
        d.price,
        d.language,
        d.nb_copies
    FROM 
        {{ source('raw_translations', 'translations') }} AS t,
        UNNEST (t.documents) AS d

)

SELECT * FROM translation_source
