
with base as (

    select * 
    from {{ ref('stg_shopify__abandoned_checkout_discount_code_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify__abandoned_checkout_discount_code_tmp')),
                staging_columns=get_abandoned_checkout_discount_code_columns()
            )
        }}
        , row_number() over(partition by checkout_id, discount_id order by index desc) as n

        {{ fivetran_utils.source_relation(
            union_schema_variable='shopify_union_schemas', 
            union_database_variable='shopify_union_databases') 
        }}

    from base
),

final as (
    
    select 
        checkout_id,
        code,
        discount_id,
        amount,
        type,
        cast(created_at as {{ dbt.type_timestamp() }}) as created_at,
        cast(updated_at as  {{ dbt.type_timestamp() }}) as updated_at,
        cast(_fivetran_synced as {{ dbt.type_timestamp() }}) as _fivetran_synced,
        source_relation

    from fields
    where n = 1
)

select *
from final
