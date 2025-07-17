{{ config(enabled=var('shopify_api', 'rest') == var('shopify_api_override','graphql')) }}

with base as (

    select * 
    from {{ ref('stg_shopify_gql__discount_application_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify_gql__discount_application_tmp')),
                staging_columns=get_graphql_discount_application_columns()
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
        lower(allocation_method) as allocation_method, -- was lowercase in old api, upper in gql
        {# no code rn #}
        null as code, -- for development
        {# description, #}
        index,
        order_id,
        lower(target_selection) as target_selection, -- was lowercase in old api, upper in gql
        lower(target_type) as target_type, -- was lowercase in old api, upper in gql
        {# no title, #}
        {# no type #}
        value_amount,
        value_percentage,
        value_currency_code,
        case 
            when value_percentage is not null then 'percentage'
            when lower(target_type) = 'shipping_line' then 'shipping'
            when value_amount is not null then 'fixed_amount'
        else null end as value_type,
        {{ shopify_source.fivetran_convert_timezone(column='cast(_fivetran_synced as ' ~ dbt.type_timestamp() ~ ')', target_tz=var('shopify_timezone', "UTC"), source_tz="UTC") }} as _fivetran_synced,
        source_relation

    from fields
)

select *
from final
