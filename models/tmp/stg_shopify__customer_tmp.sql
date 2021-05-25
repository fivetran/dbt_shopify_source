{% if var('union_schemas', none) %}

    {% set relations = [] %}

    {% for schema in var('union_schemas') %}

    {% set relation=adapter.get_relation(
        database=var('shopify_database', target.database),
        schema=schema,
        identifier="customer"
    ) -%}

    {% do relations.append(relation) %}

    {% endfor %}

    {{ dbt_utils.union_relations(relations) }}

{% elif var('union_databases', none) %}

    {% set relations = [] %}

    {% for database in var('union_databases') %}

    {% set relation=adapter.get_relation(
        database=database,
        schema=var('shopify_schema', 'shopify'),
        identifier="customer"
    ) -%}

    {% do relations.append(relation) %}

    {% endfor %}

    {{ dbt_utils.union_relations(relations) }}

{% else %}

    select * 
    from {{ var('customer_source') }}

{% endif %}