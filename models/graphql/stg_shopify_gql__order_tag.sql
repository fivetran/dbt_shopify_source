
with base as (

    select * 
    from {{ ref('stg_shopify_gql__order_tag_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify_gql__order_tag_tmp')),
                staging_columns=get_graphql_order_tag_columns()
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
        index,
        order_id,
        value
    from fields
)

select *
from final
