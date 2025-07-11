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
        id as fulfillment_id,
        location_id,
        order_id,
        name,
        service_id as service,
        lower(display_status) as shipment_status,
        lower(status) as status,
        {# for tracking_company, tracking_number, tracking_numbers, tracking_urls - join in fulfillment_tracking #}
        {{ shopify_source.fivetran_convert_timezone(column='cast(created_at as ' ~ dbt.type_timestamp() ~ ')', target_tz=var('shopify_timezone', "UTC"), source_tz="UTC") }} as created_at,
        {{ shopify_source.fivetran_convert_timezone(column='cast(updated_at as ' ~ dbt.type_timestamp() ~ ')', target_tz=var('shopify_timezone', "UTC"), source_tz="UTC") }} as updated_at,
        {{ shopify_source.fivetran_convert_timezone(column='cast(_fivetran_synced as ' ~ dbt.type_timestamp() ~ ')', target_tz=var('shopify_timezone', "UTC"), source_tz="UTC") }} as _fivetran_synced,
        source_relation


        {# REMOVE
        delivered_at,
        estimated_delivery_at,
        in_transit_at,
        origin_address_1,
        origin_address_2,
        origin_address_city,
        origin_address_country_code,
        origin_address_province_code,
        origin_address_zip,
        requires_shipping,
        total_quantity #}

    from fields
)

select *
from final
