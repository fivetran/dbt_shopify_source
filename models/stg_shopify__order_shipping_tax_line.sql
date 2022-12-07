
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
        order_shipping_line_id,
        index,
        price,
        price_set,
        rate,
        title,
        _fivetran_synced

    from fields
)

select *
from final
