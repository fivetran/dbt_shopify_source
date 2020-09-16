with source as (

    select * from {{ ref('stg_shopify__order_tmp') }}

),

renamed as (

    select
    
        {{
            fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify__order_tmp')),
                staging_columns=get_order_columns()
            )
        }}

    from source

)

select * from renamed