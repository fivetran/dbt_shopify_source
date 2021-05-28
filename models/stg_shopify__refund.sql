
with source as (

    select * 
    from {{ ref('stg_shopify__refund_tmp') }}

),

renamed as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify__refund_tmp')),
                staging_columns=get_refund_columns()
            )
        }}

      {{ source_relation() }}
        
    from source
)

select * from renamed
