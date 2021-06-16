
with base as (

    select * 
    from {{ ref('stg_shopify__checkout_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify__checkout_tmp')),
                staging_columns=get_checkout_columns()
            )
        }}
        
    from base
),

final as (
    
    select *
    from fields
)

select * from final
