
with base as (

    select * 
    from {{ ref('stg_shopify_gql__fulfillment_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify_gql__fulfillment_tmp')),
                staging_columns=get_graphql_fulfillment_columns()
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
        created_at,
        delivered_at,
        display_status,
        estimated_delivery_at,
        id as fulfillment_id,
        in_transit_at,
        location_id,
        name as fulfillment_name,
        order_id,
        origin_address_1,
        origin_address_2,
        origin_address_city,
        origin_address_country_code,
        origin_address_province_code,
        origin_address_zip,
        requires_shipping,
        service_id,
        status,
        total_quantity,
        updated_at
    from fields
)

select *
from final
