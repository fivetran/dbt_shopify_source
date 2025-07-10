
with base as (

    select * 
    from {{ ref('stg_shopify_gql__refund_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify_gql__refund_tmp')),
                staging_columns=get_graphql_refund_columns()
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
        source_relation, 
        _fivetran_synced,
        created_at,
        id as refund_id,
        note,
        order_id,
        return_id,
        staff_member_id,
        total_refunded_set_pres_amount,
        total_refunded_set_pres_currency_code,
        total_refunded_set_shop_amount,
        total_refunded_set_shop_currency_code,
        updated_at
    from fields
)

select *
from final
