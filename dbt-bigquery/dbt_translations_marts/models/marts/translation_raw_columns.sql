WITH source AS (
    SELECT 
        translation_id,
        client_id,
        total,
        payment,
        rest,
        {{ date_info('created_at') }},
        {{ diff_date('created_at', 'TIMESTAMP(CURRENT_DATETIME())' ) }}
    FROM 
        {{ ref('stg_fact_translations') }}
    WHERE 
        total <> payment
),
all_docs AS (
    SELECT 
        s.translation_id,
        CONCAT(last_name,' ',first_name) AS client_name,
        created_at_month,
        created_at_week_day,
        created_at_hour_day,
        time_spent_hours,
        time_spent_days,
        total,
        payment,
        rest,
        COUNT(*) AS number_docs,
        SUM(sltd.nb_copies) AS total_pages,
        ARRAY_AGG(STRUCT(dd.document_name AS document_name, dd.standardized_name AS standardized_name,  sltd.price AS price, sltd.language AS language, sltd.nb_copies AS nb_copies)) AS documents
        /*ARRAY_AGG(dd.document_name ORDER BY dd.document_name) AS doc_name_array*/
        /*STRING_AGG(dd.document_name, ' + ' ORDER BY dd.document_name) AS doc_names*/
    FROM 
        source s 
        INNER JOIN {{ ref('stg_clients') }} c ON s.client_id = c.id
        INNER JOIN {{ ref('stg_ligne_translation_documents') }} sltd ON s.translation_id = sltd.translation_id
        INNER JOIN {{ ref('stg_documents') }} dd ON sltd.document_id = dd.id
    GROUP BY
        1,2,3,4,5,6,7,8,9,10
)

SELECT 
        translation_id,
        client_name,
        total,
        payment,
        rest,
        number_docs,
        total_pages,
        created_at_month,
        created_at_week_day,
        created_at_hour_day,
        time_spent_hours,
        time_spent_days,
        {{ generate_doc_struct_columns(10) }}
        
FROM 
    all_docs
