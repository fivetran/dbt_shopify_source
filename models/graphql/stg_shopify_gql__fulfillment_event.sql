
with base as (

    select * 
    from {{ ref('stg_shopify_gql__fulfillment_event_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify_gql__fulfillment_event_tmp')),
                staging_columns=get_graphql_fulfillment_event_columns()
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
        _fivetran_deleted,
        _fivetran_synced,
        address_1,
        city,
        country,
        created_at,
        estimated_delivery_at,
        fulfillment_id,
        happened_at,
        id as fulfillment_event_id,
        latitude,
        longitude,
        message,
        province,
        status,
        zip
    from fields
)

select *
from final
