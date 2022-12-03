
with base as (

    select * 
    from {{ ref('stg_shopify__discount_code_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify__discount_code_tmp')),
                staging_columns=get_discount_code_columns()
            )
        }}
    from base
),

final as (
    
    select 
        _fivetran_synced,
        code,
        created_at,
        id as discount_code_id,
        price_rule_id,
        updated_at,
        usage_count
        
    from fields
)

select *
from final
