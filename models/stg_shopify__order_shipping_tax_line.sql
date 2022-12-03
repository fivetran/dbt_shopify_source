
with base as (

    select * 
    from {{ ref('stg_shopify__order_shipping_tax_line_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify__order_shipping_tax_line_tmp')),
                staging_columns=get_order_shipping_tax_line_columns()
            )
        }}
    from base
),

final as (
    
    select 
[0m22:57:40  [[33mWARNING[0m]: Configuration paths exist in your dbt_project.yml file which do not apply to any resources.
There are 2 unused configuration paths:
- models.netsuite
- models.ad_reporting

[0m22:57:43          _fivetran_synced,
        index,
        order_shipping_line_id,
        price,
        price_set,
        rate,
        title
    from fields
)

select *
from final
