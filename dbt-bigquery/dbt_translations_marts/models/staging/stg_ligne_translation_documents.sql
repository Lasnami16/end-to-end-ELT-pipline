WITH translation_source AS (
    SELECT
        GENERATE_UUID() AS id,
        _id AS translation_id,
        d.document_id,
        d.price,
        d.language,
        d.nb_copies
    FROM 
        {{source('raw_translations','translations')}}, UNNEST (documents) AS d

    )

SELECT * FROM translation_source