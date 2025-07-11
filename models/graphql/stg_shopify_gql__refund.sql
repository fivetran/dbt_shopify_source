
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
        id as refund_id,
        note,
        order_id,
        {# join in order_line_refund.restocked for restock #}
        {# no total_duties yet #}
        staff_member_id as user_id,
        {{ shopify_source.fivetran_convert_timezone(column='cast(created_at as ' ~ dbt.type_timestamp() ~ ')', target_tz=var('shopify_timezone', "UTC"), source_tz="UTC") }} as created_at,
        {# {{ shopify_source.fivetran_convert_timezone(column='cast(processed_at as ' ~ dbt.type_timestamp() ~ ')', target_tz=var('shopify_timezone', "UTC"), source_tz="UTC") }} as processed_at, #}
        {{ shopify_source.fivetran_convert_timezone(column='cast(_fivetran_synced as ' ~ dbt.type_timestamp() ~ ')', target_tz=var('shopify_timezone', "UTC"), source_tz="UTC") }} as _fivetran_synced,
        source_relation

        {# return_id,
        total_refunded_set_pres_amount,
        total_refunded_set_pres_currency_code,
        total_refunded_set_shop_amount,
        total_refunded_set_shop_currency_code, #}
        
    from fields
)

select *
from final
