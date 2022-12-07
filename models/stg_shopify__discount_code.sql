
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
        id as discount_code_id,
        code,
        price_rule_id,
        usage_count,
        created_at,
        updated_at,
        _fivetran_synced
        
    from fields
)

select *
from final
