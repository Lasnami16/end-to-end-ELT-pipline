{% macro date_info(column_name) %}
    EXTRACT(QUARTER FROM {{ column_name }}) AS {{ column_name }}_quarter,
    FORMAT_TIMESTAMP('%Y-%m', {{ column_name }}) AS {{ column_name }}_month,
    FORMAT_TIMESTAMP('%A', {{ column_name }}) AS {{ column_name }}_week_day,
    EXTRACT(HOUR FROM {{ column_name }}) AS {{ column_name }}_hour_day
{% endmacro %}



{% macro diff_date(start_column, end_column) %}
    TIMESTAMP_DIFF({{ end_column }}, {{ start_column }}, DAY) AS time_spent_days,
    TIMESTAMP_DIFF(CAST({{ end_column }} AS DATE), CAST({{ start_column }} AS DATE), MONTH) AS time_spent_months,
    TIMESTAMP_DIFF({{ end_column }}, {{ start_column }}, HOUR) AS time_spent_hours,
    TIMESTAMP_DIFF({{ end_column }}, {{ start_column }}, MINUTE) AS time_spent_minutes
{% endmacro %}


