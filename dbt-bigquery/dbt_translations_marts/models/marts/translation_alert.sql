-- models/translation_alert.sql

with base as (
  select
    translation_id,
    payment,
    total,
    rest,
    created_at

  from 
    {{ ref('stg_fact_translations') }}
  where
    payment < total
),

alerted as (

  select
    translation_id,
    payment,
    total,
    rest,
    created_at,
    {{ get_alert('created_at') }} AS alert

  from base

)

select * from alerted
