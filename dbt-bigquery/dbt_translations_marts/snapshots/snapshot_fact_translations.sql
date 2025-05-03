{% snapshot snapshot_fact_translations %}

{{
    config(
        target_schema='snapshots',
        unique_key='_id',
        strategy='timestamp',
        updated_at='updated_at'
    )
}}

SELECT 
   *
FROM 
    {{ source('raw_translations', 'translations') }}

{% endsnapshot %}
