{% macro generate_date_key(timestamp_column) %}
    CAST(TO_CHAR({{timestamp_column}}, 'YYYYMMDD') AS INTEGER)
{% endmacro %}