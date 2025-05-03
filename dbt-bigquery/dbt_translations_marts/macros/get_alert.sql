{% macro get_alert(created_at) %}
  case
    when date_diff(current_timestamp(), {{ created_at }}, day) > 15 then 'over_15_days'
    when date_diff(current_timestamp(), {{ created_at }}, day) > 7 then 'over_7_days'
    else 
      concat(cast(date_diff(current_timestamp(), {{ created_at }}, day) as string), '_days')
  end
{% endmacro %}
