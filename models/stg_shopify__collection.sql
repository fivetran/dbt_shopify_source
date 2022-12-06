
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
    from base
),

final as (
    
    select 
        _fivetran_deleted as is_deleted,
        _fivetran_synced,
        case 
            when disjunctive is null then null
            when disjunctive then 'disjunctive'
            else 'conjunctive' end as rule_logic,
        handle,
        id as collection_id,
        published_at,
        published_scope,
        rules,
        sort_order,
        title,
        updated_at

    from fields
)

select *
from final
