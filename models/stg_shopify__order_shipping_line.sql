with source as (

    select * from {{ ref('stg_shopify__order_shipping_line_tmp') }}

),

renamed as (

    select
    
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify__order_shipping_line_tmp')),
                staging_columns=get_order_shipping_line_columns()
            )
        }}

    from source

)

select * from renamed

