
with base as (

    select * 
    from {{ ref('stg_shopify__fulfillment_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify__fulfillment_tmp')),
                staging_columns=get_fulfillment_columns()
            )
        }}
    from base
),

final as (
    
    select 
[0m22:57:09  [[33mWARNING[0m]: Configuration paths exist in your dbt_project.yml file which do not apply to any resources.
There are 2 unused configuration paths:
- models.netsuite
- models.ad_reporting

[0m22:57:12          _fivetran_synced,
        created_at,
        id,
        location_id,
        name,
        order_id,
        receipt_authorization,
        service,
        shipment_status,
        status,
        tracking_company,
        tracking_number,
        tracking_numbers,
        tracking_urls,
        updated_at
    from fields
)

select *
from final
