
with base as (

    select * 
    from {{ ref('stg_shopify_gql__inventory_item_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify_gql__inventory_item_tmp')),
                staging_columns=get_graphql_inventory_item_columns()
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
        _fivetran_deleted,
        _fivetran_synced,
        country_code_of_origin,
        created_at,
        duplicate_sku_count,
        harmonized_system_code,
        id as inventory_item_id,
        inventory_history_url,
        legacy_resource_id,
        measurement_id,
        measurement_weight_unit,
        measurement_weight_value,
        province_code_of_origin,
        requires_shipping,
        sku,
        tracked,
        tracked_editable_locked,
        tracked_editable_reason,
        unit_cost_amount,
        unit_cost_currency_code,
        updated_at
    from fields
)

select *
from final
