--To disable this model, set the shopify__using_refund variable within your dbt_project.yml file to False.
{{ config(enabled=var('shopify__using_refund', True)) }}

with base as (

    select * 
    from {{ ref('stg_shopify__refund_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify__refund_tmp')),
                staging_columns=get_refund_columns()
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
        restock,
        total_duties_set,
        user_id,
        cast(created_at as {{ dbt.type_timestamp() }}) as created_at,
        cast(processed_at as {{ dbt.type_timestamp() }}) as processed_at,
        cast(_fivetran_synced as {{ dbt.type_timestamp() }}) as _fivetran_synced,
        source_relation

    from fields
)

select * 
from final