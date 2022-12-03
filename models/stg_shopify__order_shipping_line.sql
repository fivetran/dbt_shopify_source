
with base as (

    select * 
    from {{ ref('stg_shopify__order_shipping_line_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify__order_shipping_line_tmp')),
                staging_columns=get_order_shipping_line_columns()
            )
        }}
    from base
),

final as (
    
    select 
[0m22:57:34  [[33mWARNING[0m]: Configuration paths exist in your dbt_project.yml file which do not apply to any resources.
There are 2 unused configuration paths:
- models.netsuite
- models.ad_reporting

[0m22:57:37          _fivetran_synced,
        carrier_identifier,
        code,
        delivery_category,
        discounted_price,
        discounted_price_set,
        id,
        order_id,
        phone,
        price,
        price_set,
        requested_fulfillment_service_id,
        source,
        title
    from fields
)

select *
from final
