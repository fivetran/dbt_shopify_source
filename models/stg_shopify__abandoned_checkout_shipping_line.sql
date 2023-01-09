
with base as (

    select * 
    from {{ ref('stg_shopify__abandoned_checkout_shipping_line_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify__abandoned_checkout_shipping_line_tmp')),
                staging_columns=get_abandoned_checkout_shipping_line_columns()
            )
        }}
    from base
),

final as (
    
    select 
        id as abandoned_checkout_shipping_line_id,
        checkout_id,
        index,
        api_client_id,
        carrier_identifier,
        carrier_service_id,
        code as shipping_code,
        delivery_category,
        delivery_expectation_range,
        delivery_expectation_range_max,
        delivery_expectation_range_min,
        delivery_expectation_type,
        discounted_price,
        markup,
        original_shop_markup,
        original_shop_price,
        phone,
        presentment_title,
        price,
        requested_fulfillment_service_id,
        source,
        title,
        validation_context,
        {{ dbt_date.convert_timezone(column='cast(_fivetran_synced as ' ~ dbt.type_timestamp() ~ ')', target_tz=var('shopify_timezone', "UTC"), source_tz="UTC") }} as _fivetran_synced,
        source_relation

    from fields
)

select *
from final
