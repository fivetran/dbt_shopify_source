{% macro source_relation() %}

{% if var('union_schemas', none)  %}
, case
    {% for schema in var('union_schemas') %}
    when lower(replace(_dbt_source_relation,'"','')) like '%.{{ schema|lower }}.%' then '{{ schema|lower }}'
    {% endfor %}
  end as source_relation
{% elif var('union_databases', none) %}
, case
    {% for database in var('union_databases') %}
    when lower(replace(_dbt_source_relation,'"','')) like '%{{ database|lower }}.%' then '{{ database|lower }}'
    {% endfor %}
  end as source_relation
{% else %}
, '' as source_relation
{% endif %}

{% endmacro %}