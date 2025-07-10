
with base as (

    select * 
    from {{ ref('stg_shopify_gql__location_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify_gql__location_tmp')),
                staging_columns=get_graphql_location_columns()
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
        activatable,
        address_1,
        address_2,
        address_verified,
        city,
        country,
        country_code,
        created_at,
        deactivatable,
        deactivated_at,
        deletable,
        fulfillment_service_id,
        fulfills_online_orders,
        has_active_inventory,
        has_unfulfilled_orders,
        id as location_id,
        is_active,
        is_fulfillment_service,
        latitude,
        local_pickup_settings_instructions,
        local_pickup_settings_pickup_time,
        longitude,
        name as location_name,
        phone,
        province,
        province_code,
        ships_inventory,
        updated_at,
        zip
    from fields
)

select *
from final
