
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
[0m20:31:45  [[33mWARNING[0m]: Configuration paths exist in your dbt_project.yml file which do not apply to any resources.
There are 2 unused configuration paths:
- models.netsuite
- models.ad_reporting

[0m20:31:48          _fivetran_synced,
        api_client_id,
        carrier_identifier,
        carrier_service_id,
        checkout_id,
        code,
        delivery_category,
        delivery_expectation_range,
        delivery_expectation_range_max,
        delivery_expectation_range_min,
        delivery_expectation_type,
        discounted_price,
        id,
        index,
        markup,
        original_shop_markup,
        original_shop_price,
        phone,
        presentment_title,
        price,
        requested_fulfillment_service_id,
        source,
        title,
        validation_context
    from fields
)

select *
from final
