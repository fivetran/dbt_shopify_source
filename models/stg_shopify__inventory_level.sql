
with base as (

    select * 
    from {{ ref('stg_shopify__inventory_level_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify__inventory_level_tmp')),
                staging_columns=get_inventory_level_columns()
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
        inventory_item_id,
        location_id,
        available as available_quantity,
        cast(updated_at as {{ dbt.type_timestamp() }}) as updated_at,
        cast(_fivetran_synced as {{ dbt.type_timestamp() }}) as _fivetran_synced,
        source_relation
        
    from fields
)

select *
from final
