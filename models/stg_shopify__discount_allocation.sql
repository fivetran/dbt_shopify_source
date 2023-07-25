with base as (

    select * 
    from {{ ref('stg_shopify__discount_allocation_tmp') }}

),

fields as (

    select
    
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify__discount_allocation_tmp')),
                staging_columns=get_discount_allocation_columns()
            )
        }}

        {{ fivetran_utils.source_relation(
            union_schema_variable='shopify_union_schemas', 
            union_database_variable='shopify_union_databases') 
        }}

    from base

),

final as (
    
    select 
        order_line_id,
        amount
    from fields

)

select * 
from final
