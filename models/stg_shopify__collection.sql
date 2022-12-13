
with base as (

    select * 
    from {{ ref('stg_shopify__collection_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify__collection_tmp')),
                staging_columns=get_collection_columns()
            )
        }}

        {{ fivetran_utils.source_relation(
            union_schema_variable='shopify_union_schemas', 
            union_database_variable='shopify_union_databases') 
        }}

    from base
),

final as (
    
    select 
        id as collection_id,
        _fivetran_deleted as is_deleted,
        case 
            when disjunctive is null then null
            when disjunctive then 'disjunctive'
            else 'conjunctive' end as rule_logic,
        handle,
        cast(published_at as {{ dbt.type_timestamp() }}) as published_at,
        published_scope,
        rules,
        sort_order,
        title,
        cast(updated_at as {{ dbt.type_timestamp() }}) as updated_at,
        cast(_fivetran_synced as {{ dbt.type_timestamp() }}) as _fivetran_synced,
        source_relation

    from fields
)

select *
from final
