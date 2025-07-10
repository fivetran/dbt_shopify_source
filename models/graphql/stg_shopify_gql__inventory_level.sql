
with base as (

    select * 
    from {{ ref('stg_shopify_gql__inventory_level_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify_gql__inventory_level_tmp')),
                staging_columns=get_graphql_inventory_level_columns()
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
        source_relation, 
        _fivetran_synced,
        can_deactivate,
        created_at,
        deactivation_alert,
        id as inventory_level_id,
        inventory_item_id,
        location_id,
        updated_at
    from fields
)

select *
from final
