
with base as (

    select * 
    from {{ ref('stg_shopify_gql__inventory_quantity_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify_gql__inventory_quantity_tmp')),
                staging_columns=get_graphql_inventory_quantity_columns()
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
        id as inventory_quantity_id,
        inventory_item_id,
        inventory_level_id,
        name as inventory_quantity_name,
        quantity,
        updated_at
    from fields
)

select *
from final
