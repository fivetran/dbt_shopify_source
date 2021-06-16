
with base as (

    select * 
    from {{ ref('stg_shopify__abandoned_checkout_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify__abandoned_checkout_tmp')),
                staging_columns=get_abandoned_checkout_columns()
            )
        }}
        
    from base
),

final as (
    
    select *
    from fields
)

select * from final
