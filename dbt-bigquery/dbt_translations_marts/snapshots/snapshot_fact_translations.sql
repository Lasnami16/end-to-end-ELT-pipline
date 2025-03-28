{% snapshot snapshot_fact_translations %}

{{
    config(
        target_schema='snapshots',
        unique_key='translation_id',
        strategy='timestamp',
        updated_at='updated_at'
    )
}}

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
FROM {{ source('raw_translations', 'translations') }}

{% endsnapshot %}
