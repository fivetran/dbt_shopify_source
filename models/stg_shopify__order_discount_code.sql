
with base as (

    select * 
    from {{ ref('stg_shopify__order_discount_code_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify__order_discount_code_tmp')),
                staging_columns=get_order_discount_code_columns()
            )
        }}
    from base
),

final as (
    
    select 
        order_id,
        code,
        type,
        amount,
        _fivetran_synced

    from fields
    where index = 1 -- Sanity check. index should not > 1 but open an issue if that's not the case in your data
)

select *
from final
