with ranked_payments as (

  select
    translation_id,
    price,
    payment_at,
    row_number() over (partition by translation_id order by payment_at asc) as payment_rank

  from {{ ref('stg_ligne_translation_payments') }}

), pivoted as (

  select
    translation_id,

    -- Payment 1
    max(case when payment_rank = 1 then price end) as payment_1,
    max(case when payment_rank = 1 then payment_at end) as payment_at_1,

    -- Payment 2
    max(case when payment_rank = 2 then price end) as payment_2,
    max(case when payment_rank = 2 then payment_at end) as payment_at_2,

    -- Payment 3
    max(case when payment_rank = 3 then price end) as payment_3,
    max(case when payment_rank = 3 then payment_at end) as payment_at_3,

    -- Payment 4
    max(case when payment_rank = 4 then price end) as payment_4,
    max(case when payment_rank = 4 then payment_at end) as payment_at_4,

    -- Payment 5
    max(case when payment_rank = 5 then price end) as payment_5,
    max(case when payment_rank = 5 then payment_at end) as payment_at_5

  from ranked_payments
  group by translation_id

), translation_fact as (

  select  
    translation_id,
    created_at
  from {{ ref('stg_fact_translations') }}

)


select 
    * 
from 
    translation_fact t
join pivoted p on t.translation_id = p.translation_id
ORDER BY t.created_at DESC

